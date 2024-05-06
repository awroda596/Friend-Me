from django.urls import path
from events import views

urlpatterns = [
    # custom URL patterns for direct view functions
    path('eventsdetails/', views.eventsdetails, name='eventsdetails'),
    path('eventsdetails_uid/<str:uid>/', views.events_by_uid, name='events_by_uid'),
    path('eventsdetails_id/<int:pk>/', views.event_detail, name='event_detail'),
]
