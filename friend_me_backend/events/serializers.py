from rest_framework import serializers

from .models import Event


class EventSerializer(serializers.ModelSerializer):
  creator_name = serializers.RelatedField(
    source='creator', 
    read_only=True)
  class Meta:
    model = Event
    fields = [
      'title',
      'description',
      'start_time',
      'end_time',
      'created_at',
      'updated_at'
    ]