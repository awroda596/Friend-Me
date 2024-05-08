from typing import Any
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.models import User, BaseUserManager
#FriendRequest = apps.get_model('profiles','FriendRequest')

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user



class CustomUser(AbstractUser):
    # can add additional fields as needed
    objects = CustomUserManager()
    email = models.EmailField(('email address'), unique=True, blank=False, error_messages={
        'unique': ("A user with that email already exists."),
    })
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'first_name', 'last_name']
    def __str__(self) -> str:
        return self.username
    
    class Meta:
        db_table = "user"

    # def send_friend_request(self, to_user):
    #     if to_user != self and not FriendRequest.objects.filter(from_user=self, to_user=to_user).exists():
    #         FriendRequest.objects.create(from_user=self, to_user=to_user)

    # def accept_friend_request(self, from_user):
    #     friend_request = FriendRequest.objects.get(from_user=from_user, to_user=self, status='pending')
    #     friend_request.status = 'accepted'
    #     friend_request.save()

    # def decline_friend_request(self, from_user):
    #     friend_request = FriendRequest.objects.get(from_user=from_user, to_user=self)
    #     friend_request.status = 'declined'
    #     friend_request.save()

    # def get_friend_list(self):
    #     accepted_requests = FriendRequest.objects.filter(Q(from_user=self) | Q(to_user=self), status='accepted')
    #     friends = set(request.to_user for request in accepted_requests if request.to_user != self)
    #     friends.update(request.from_user for request in accepted_requests if request.from_user != self)
    #     return friends

    # def get_sent_friend_requests(self):
    #     return FriendRequest.objects.filter(from_user=self, status='pending')

    # def get_received_friend_requests(self):
    #     return FriendRequest.objects.filter(to_user=self, status='pending')
