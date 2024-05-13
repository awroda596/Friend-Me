from django.contrib.auth import authenticate
from rest_framework import status, views
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from .serializers import UserSerializer
from users.models import CustomUser
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json

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
        
@csrf_exempt
def usersdetails(request, format=None):
    if request.method == 'GET':
        userid = request.headers.get('Authorization')
        users = CustomUser.objects
        serializer = UserSerializer(users, many=True)
        return JsonResponse(serializer.data, safe=False)
    elif request.method == 'POST':
        rdata = json.loads(request.body)
        print(rdata)
        serializer = UserSerializer(data=rdata)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'PUT':
        rdata = json.loads(request.body)
        try:
            user = CustomUser.objects.filter(id=rdata['id'])
        except CustomUser.DoesNotExist:
            return JsonResponse({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND) 
        serializer = UserSerializer(user, data=rdata)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'DELETE':    
        rdata = json.loads(request.body)
        try:
            user = CustomUser.objects.filter(id=rdata['id'])
        except CustomUser.DoesNotExist:
            return JsonResponse({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)           
        user.delete()
        return JsonResponse({'message': 'User deleted successfully'}, status=status.HTTP_204_NO_CONTENT)