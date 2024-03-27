from django.shortcuts import render, redirect
from events.models import Event
from .serializers import EventSerializer
from rest_framework import viewsets

# Create your views here.
class Event(viewsets.ModelViewSet):
    queryset = Event.objects.all()
    serializer_class = EventSerializer