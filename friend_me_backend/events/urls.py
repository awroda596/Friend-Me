from django.urls import path, include
from rest_framework import routers
from rest_framework.routers import DefaultRouter
from events import views

router = routers.DefaultRouter(trailing_slash=False)
router.register(r'eventsdetails', views.Event)

urlpatterns = [
    path('', include(router.urls)),
    #url('events/<int:id>/', events_list.as_view()),
]
