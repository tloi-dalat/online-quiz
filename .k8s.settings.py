from urllib.parse import urlsplit


def _env(key, default=None, required=False, cast=str):
    v = os.environ.get(key)
    if v is None or v == '':
        if required and not os.environ.get('BUILD_MODE'):
            raise RuntimeError('missing required environment variable: %s' % key)
        return default
    if cast is bool:
        return v.strip().lower() in ('1', 'true', 'yes', 'on')
    if cast is list:
        return [x.strip() for x in v.split(',') if x.strip()]
    return cast(v)


SITE_FULL_URL = _env('SITE_FULL_URL', 'http://localhost', required=True).rstrip('/')
_DOMAIN = urlsplit(SITE_FULL_URL).hostname


SECRET_KEY = _env('SECRET_KEY', 'build-only-not-a-real-key', required=True)
DEBUG = _env('DEBUG', False, cast=bool)
ALLOWED_HOSTS = _env('ALLOWED_HOSTS', [_DOMAIN], cast=list)


SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
CSRF_TRUSTED_ORIGINS = [SITE_FULL_URL]
SESSION_COOKIE_SECURE = not DEBUG
CSRF_COOKIE_SECURE = not DEBUG

MIDDLEWARE = ('tloq.cf_realip.CloudflareRealIPMiddleware',
              'whitenoise.middleware.WhiteNoiseMiddleware') + tuple(MIDDLEWARE)


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': _env('DATABASE_NAME', 'online_quiz'),
        'USER': _env('DATABASE_USER', 'online_quiz'),
        'PASSWORD': _env('DATABASE_PASSWORD', ''),
        'HOST': _env('DATABASE_HOST', 'postgres-primary.database.svc.cluster.local'),
        'PORT': _env('DATABASE_PORT', 5432, cast=int),
        'CONN_MAX_AGE': _env('DATABASE_CONN_MAX_AGE', 60, cast=int),
        'CONN_HEALTH_CHECKS': True,
    },
}


_redis_pw = _env('REDIS_PASSWORD', '')
_redis_base = 'redis://%s%s:%s' % (':%s@' % _redis_pw if _redis_pw else '',
                                   _env('REDIS_HOST', 'redis'), _env('REDIS_PORT', 6379, cast=int))

CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': '%s/%s' % (_redis_base, _env('REDIS_CACHE_DB', 1, cast=int)),
        'OPTIONS': {'CLIENT_CLASS': 'django_redis.client.DefaultClient'},
    },
}


LANGUAGE_CODE = 'vi'
TIME_ZONE = 'Asia/Ho_Chi_Minh'
USE_I18N = True
USE_TZ = True


STATIC_ROOT = _env('STATIC_ROOT', os.path.join(BASE_DIR, 'static'))
STATIC_URL = '/static/'
STORAGES = {
    'default': {'BACKEND': 'django.core.files.storage.FileSystemStorage'},
    'staticfiles': {'BACKEND': 'django.contrib.staticfiles.storage.ManifestStaticFilesStorage'},
}

WHITENOISE_ROOT = os.path.join(BASE_DIR, 'rootfiles')

MEDIA_ROOT = _env('MEDIA_ROOT', '/media')
MEDIA_URL = _env('MEDIA_URL', '/media/')


EMAIL_BACKEND = _env('EMAIL_BACKEND', 'django.core.mail.backends.smtp.EmailBackend')
EMAIL_HOST = _env('EMAIL_HOST', 'localhost')
EMAIL_PORT = _env('EMAIL_PORT', 25, cast=int)
EMAIL_USE_TLS = _env('EMAIL_USE_TLS', False, cast=bool)
EMAIL_HOST_USER = _env('EMAIL_HOST_USER', '')
EMAIL_HOST_PASSWORD = _env('EMAIL_HOST_PASSWORD', '')
EMAIL_TIMEOUT = _env('EMAIL_TIMEOUT', 10, cast=int)

DEFAULT_FROM_EMAIL = _env('DEFAULT_FROM_EMAIL', 'TLOI Support <support@tloi.vn>')
SERVER_EMAIL = _env('SERVER_EMAIL', 'support@tloi.vn')

ADMINS = tuple(tuple(pair.split(':', 1)) for pair in _env('ADMINS', [], cast=list) if ':' in pair)


SITE_NAME = _env('SITE_NAME', 'TLOQ')
SITE_LONG_NAME = _env('SITE_LONG_NAME', 'TLOQ: Thang Long Da Lat Online Quiz')
SITE_ADMIN_EMAIL = _env('SITE_ADMIN_EMAIL', 'support@tloi.vn')


_LOG_LEVEL = _env('LOG_LEVEL', 'INFO')
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'file': {'format': '%(levelname)s %(asctime)s %(module)s %(message)s'},
    },
    'handlers': {
        'console': {'level': 'DEBUG', 'class': 'logging.StreamHandler', 'formatter': 'file'},
        'mail_admins': {'level': 'ERROR', 'class': 'django.utils.log.AdminEmailHandler'},
    },
    'loggers': {
        'django.request': {'handlers': ['mail_admins', 'console'], 'level': 'ERROR', 'propagate': False},
        '': {'handlers': ['console'], 'level': _LOG_LEVEL},
    },
}
