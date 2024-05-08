from rest_framework import serializers
from .models import UserProfile

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['id', 'user', 'uid', 'public_name', 'private_name', 'bio', 'date_of_birth', 'profile_picture', 'background_image']
