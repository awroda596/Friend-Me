from .models import Event 
from rest_framework import serializers


class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = ('id', 'title', 'description', 'start_time', 'end_time', 'creator_id')

    def create(self, validated_data):
        id = validated_data.get('id')
        title = validated_data.get('title')
        description = validated_data.get('description')
        start_time = validated_data.get('start_time')  
        end_time = validated_data.get('end_time')
        creator_id = validated_data.get('creator_id')
        
        event = Event.objects.create_event(id = id, title = title, 
                                            description = description, 
                                                start_time = start_time, 
                                                end_time = end_time, 
                                                creator_id = creator_id)

        return event
