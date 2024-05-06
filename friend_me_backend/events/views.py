from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from events.models import Event
from events.serializers import EventSerializer
from rest_framework import status
import json
# events in general with no filter
# posting occurs as usual
@csrf_exempt
def eventsdetails(request, format=None):
    if request.method == 'GET':
        userid = request.headers.get('Authorization')
        events = Event.objects.filter(uid=userid)
        serializer = EventSerializer(events, many=True)
        return JsonResponse(serializer.data, safe=False)
    elif request.method == 'POST':
        rdata = json.loads(request.body)
        serializer = EventSerializer(data=rdata)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'PUT':
        rdata = json.loads(request.body)
        try:
            event = Event.objects.filter(id=rdata['id'])
        except Event.DoesNotExist:
            return JsonResponse({'error': 'Event not found'}, status=status.HTTP_404_NOT_FOUND) 
        serializer = EventSerializer(event, data=rdata)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'DELETE':    
        rdata = json.loads(request.body)
        try:
            event = Event.objects.filter(id=rdata['id'])
        except Event.DoesNotExist:
            return JsonResponse({'error': 'Event not found'}, status=status.HTTP_404_NOT_FOUND)           
        event.delete()
        return JsonResponse({'message': 'Event deleted successfully'}, status=status.HTTP_204_NO_CONTENT)


# processes requests based on uid string
@csrf_exempt
def events_by_uid(request, uid, format=None):
    try:
        event = Event.objects.filter(uid=uid)
    except Event.DoesNotExist:
        return JsonResponse({'error': 'Event not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = EventSerializer(event)
        return JsonResponse(serializer.data)
    
    elif request.method == 'PUT':
        data = json.loads(request.body)
        serializer = EventSerializer(event, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        event.delete()
        return JsonResponse({'message': 'Event deleted successfully'}, status=status.HTTP_204_NO_CONTENT)
    
# processes requests based on pk (id for event)
@csrf_exempt
def event_detail(request, pk, format=None):
    try:
        event = Event.objects.filter(pk=pk)
    except Event.DoesNotExist:
        return JsonResponse({'error': 'Event not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = EventSerializer(event)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        rdata = json.loads(request.body)
        serializer = EventSerializer(event, data=rdata)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        event.delete()
        return JsonResponse({'message': 'Event deleted successfully'}, status=status.HTTP_204_NO_CONTENT)
