from django.urls import path, include
from .views import PostEventView

urlpatterns = [
    path('postevent/', PostEventView.as_view(), name='postevent'),
]