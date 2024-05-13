from rest_framework import viewsets
from rest_framework import status
from profiles.models import UserProfile
from profiles.serializers import UserProfileSerializer
from rest_framework.permissions import IsAuthenticated, IsAdminUser, SAFE_METHODS, BasePermission
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json

class IsOwnerOrAdmin(BasePermission):
    """Allow user to edit their own profile, and give all permissions to admins."""
    def has_object_permission(self, request, view, obj):
        if request.method in SAFE_METHODS:
            return True
        return obj.user == request.user or request.user.is_staff

class UserProfileViewSet(viewsets.ModelViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer
    permission_classes = [IsAuthenticated, IsOwnerOrAdmin]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)  # Automatically associate the profile with the logged-in user

@csrf_exempt
def profilesdetails(request, format=None):
    if request.method == 'GET':
        userid = request.headers.get('Authorization')
        profiles = UserProfile.objects.filter(uid=userid)
        serializer = UserProfileSerializer(profiles, many=True)
        return JsonResponse(serializer.data, safe=False)
    elif request.method == 'POST':
        rdata = json.loads(request.body)
        serializer = UserProfileSerializer(data=rdata)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'PUT':
        rdata = json.loads(request.body)
        try:
            profile = UserProfile.objects.filter(id=rdata['id'])
        except UserProfile.DoesNotExist:
            return JsonResponse({'error': 'UserProfile not found'}, status=status.HTTP_404_NOT_FOUND) 
        serializer = UserProfileSerializer(profile, data=rdata)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'DELETE':    
        rdata = json.loads(request.body)
        try:
            profile = UserProfile.objects.filter(id=rdata['id'])
        except UserProfile.DoesNotExist:
            return JsonResponse({'error': 'UserProfile not found'}, status=status.HTTP_404_NOT_FOUND)           
        profile.delete()
        return JsonResponse({'message': 'UserProfile deleted successfully'}, status=status.HTTP_204_NO_CONTENT)