from .models import CustomUser
from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('id', 'username', 'email', 'password', 'first_name', 'last_name')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        email = validated_data.get('email')
        password = validated_data.get('password')
        username = validated_data.get('username')
        first_name = validated_data.get('first_name', '')  
        last_name = validated_data.get('last_name', '')
        
        user = CustomUser.objects.create_user(email = email, password = password,
                                               username = username, first_name = first_name,
                                                 last_name = last_name)
        return user
