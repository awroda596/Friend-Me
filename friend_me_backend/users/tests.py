from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status
from django.test import TestCase
from django.contrib.auth import get_user_model
from .serializers import UserSerializer

User = get_user_model()

class UserAccountTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.signup_url = reverse('signup')
        self.login_url = reverse('login')
        self.user_data = {
            'username': 'testuser',
            'email': 'test@example.com',
            'password': 'password123',
            'first_name': 'Test',
            'last_name': 'User'
        }

    def test_user_registration(self):
        response = self.client.post(self.signup_url, self.user_data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertIn('token', response.data)

    def test_user_login(self):
        self.client.post(self.signup_url, self.user_data)
        response = self.client.post(self.login_url, {'email': 'test@example.com', 'password': 'password123'})
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('token', response.data)

    def test_user_serializer(self):
        user = User.objects.create_user(**self.user_data)
        data = UserSerializer(user).data
        self.assertEqual(data['email'], 'test@example.com')
        self.assertNotIn('password', data)

    def test_create_user_with_invalid_email(self):
        user_data = self.user_data.copy()
        user_data['email'] = 'invalid-email'
        response = self.client.post(self.signup_url, user_data)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_duplicate_email(self):
        self.client.post(self.signup_url, self.user_data)
        response = self.client.post(self.signup_url, self.user_data)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
