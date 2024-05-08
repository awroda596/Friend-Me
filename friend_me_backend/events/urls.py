from django.urls import path
from events import views

urlpatterns = [
    path('eventsdetails/', views.eventsdetails, name='eventsdetails')
]