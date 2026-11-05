from django.contrib import admin
from django.http import HttpResponse
from django.urls import include, path


def healthz(request):
    return HttpResponse('ok', content_type='text/plain')


urlpatterns = [
    path('', include('quiz.urls')),
    path('admin/', admin.site.urls),
    path('accounts/', include('django.contrib.auth.urls')),
    path('healthz', healthz, name='healthz'),
]
