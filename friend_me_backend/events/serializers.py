from rest_framework import serializers

from .models import Event


class EventSerializer(serializers.ModelSerializer):
  class Meta:
    model = Event
    fields = [
      'description',
      'start_time',
      'end_time',
      'created_at',
      'updated_at'
    ]