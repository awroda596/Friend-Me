from django.test import TestCase
from .models import UserProfile, Friendship, FriendRequest
from rest_framework.test import APITestCase
from users.models import CustomUser
from .serializers import UserProfileSerializer
from rest_framework.test import APIClient
from rest_framework import status
from django.urls import reverse
from datetime import date
from django.db import IntegrityError


class ModelsTestCase(TestCase):
    def setUp(self):
        self.user1 = CustomUser.objects.create_user(email = "example@example.com",first_name = 'example', last_name = 'example'  , username='user1', password='pass')
        self.user2 = CustomUser.objects.create_user(email = "example2@example2.com",first_name = 'example2', last_name = 'example2'  , username='user2', password='pass')

    def test_user_profile_creation(self):
        profile = UserProfile.objects.create(
            user=self.user1,
            public_name='JohnDoe',
            date_of_birth=date(1990, 1, 1))

        self.assertEqual(profile.public_name, 'JohnDoe')

    def test_friendship_constraints(self):
        Friendship.objects.create(creator=self.user1, friend=self.user2)
        with self.assertRaises(IntegrityError):
            Friendship.objects.create(creator=self.user1, friend=self.user2) 

    def test_friend_request_status(self):
        friend_request = FriendRequest.objects.create(from_user=self.user1, to_user=self.user2)
        self.assertEqual(friend_request.status, 'pending')





class SocialNetworkTests(APITestCase):
    def setUp(self):
        self.user1 = CustomUser.objects.create_user(email = "example@example.com",first_name = 'example', last_name = 'example'  , username='user1', password='pass')
        self.user2 = CustomUser.objects.create_user(email = "example2@example2.com",first_name = 'example2', last_name = 'example2'  , username='user2', password='pass')
        self.user_profile1 = UserProfile.objects.create(user=self.user1, public_name='PublicUser1', date_of_birth='1990-01-01')
        self.user_profile2 = UserProfile.objects.create(user=self.user2, public_name='PublicUser2', date_of_birth='1990-01-02')

    def test_profile_creation(self):
        self.assertEqual(self.user_profile1.public_name, 'PublicUser1')

    def test_create_friendship(self):
        Friendship.objects.create(creator=self.user1, friend=self.user2)
        friendship = Friendship.objects.get(creator=self.user1, friend=self.user2)
        self.assertTrue(friendship)

    def test_unique_friendship(self):
        Friendship.objects.create(creator=self.user1, friend=self.user2)
        with self.assertRaises(IntegrityError):
            Friendship.objects.create(creator=self.user1, friend=self.user2)

    def test_friend_request_creation(self):
        FriendRequest.objects.create(from_user=self.user1, to_user=self.user2)
        request = FriendRequest.objects.get(from_user=self.user1, to_user=self.user2)
        self.assertEqual(request.status, 'pending')

    def test_update_friend_request_status(self):
        request = FriendRequest.objects.create(from_user=self.user1, to_user=self.user2)
        request.status = 'accepted'
        request.save()
        updated_request = FriendRequest.objects.get(from_user=self.user1, to_user=self.user2)
        self.assertEqual(updated_request.status, 'accepted')

    def test_prevent_duplicate_requests(self):
        FriendRequest.objects.create(from_user=self.user1, to_user=self.user2)
        with self.assertRaises(IntegrityError):
            FriendRequest.objects.create(from_user=self.user1, to_user=self.user2)

