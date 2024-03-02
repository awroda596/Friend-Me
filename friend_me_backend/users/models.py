from django.db import models
from django.contrib.auth.models import AbstractUser
#from django.apps import apps
#FriendRequest = apps.get_model('profiles','FriendRequest')

class CustomUser(AbstractUser):
    # can add additional fields as needed
    email = models.EmailField(unique = True)

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
