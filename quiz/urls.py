from django.urls import path

from quiz.views import HomeView

urlpatterns = [
    path('', HomeView.as_view(), name='home'),
]
