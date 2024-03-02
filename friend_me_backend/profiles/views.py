from rest_framework import viewsets
from .models import UserProfile
from .serializers import UserProfileSerializer
from rest_framework.permissions import IsAuthenticated, IsAdminUser, SAFE_METHODS, BasePermission

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
