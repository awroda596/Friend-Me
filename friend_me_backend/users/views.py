from django.contrib.auth import authenticate
from rest_framework import status, views
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from .serializers import UserSerializer

class SignupView(views.APIView):
    def post(self, request, *args, **kwargs):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            token, created = Token.objects.get_or_create(user=user)
            return Response({"token": token.key}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
class LoginView(views.APIView):
    def post(self, request, format=None):
        data = request.data
        username = data.get('email', None)
        password = data.get('password', None)
        user = authenticate(username=username, password=password)
        if user is not None:
            token, _ = Token.objects.get_or_create(user=user)
            return Response({'token': token.key}, status=status.HTTP_200_OK)
        else:
            return Response({'error': 'Invalid Credentials'}, status=status.HTTP_400_BAD_REQUEST)