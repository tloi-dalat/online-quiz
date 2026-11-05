from django.conf import settings


def site(request):
    return {
        'SITE_NAME': settings.SITE_NAME,
        'SITE_LONG_NAME': settings.SITE_LONG_NAME,
        'SITE_ADMIN_EMAIL': settings.SITE_ADMIN_EMAIL,
    }
