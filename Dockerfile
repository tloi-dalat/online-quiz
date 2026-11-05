ARG PYTHON_IMAGE=python:3.14-slim-trixie

FROM ${PYTHON_IMAGE} AS python-deps
ENV PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1
RUN python -m venv /venv
ENV PATH=/venv/bin:$PATH
COPY requirements.txt ./
RUN pip install -r requirements.txt

FROM ${PYTHON_IMAGE} AS build
RUN apt-get update \
 && apt-get install -y --no-install-recommends gettext \
 && rm -rf /var/lib/apt/lists/*
COPY --from=python-deps /venv /venv
ENV PATH=/venv/bin:$PATH
WORKDIR /app
COPY . .
COPY .k8s.settings.py tloq/local_settings.py
RUN export BUILD_MODE=1 \
 && python manage.py collectstatic --noinput \
 && python manage.py compilemessages \
 && mkdir -p rootfiles \
 && cp robots.txt rootfiles/

FROM ${PYTHON_IMAGE}
COPY --from=build /venv /venv
COPY --from=build /app /app
WORKDIR /app
ENV PATH=/venv/bin:$PATH \
    PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=tloq.settings \
    HOME=/tmp
USER 1000:1000
EXPOSE 8000
CMD ["gunicorn", "tloq.wsgi:application", \
     "--bind", "0.0.0.0:8000", \
     "--workers", "3", \
     "--timeout", "120", \
     "--max-requests", "1000", "--max-requests-jitter", "100", \
     "--access-logfile", "-"]
