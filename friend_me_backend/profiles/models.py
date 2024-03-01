from django.db import models
from django .conf import settings
# Create your models here.

class UserProfile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete = models.CASCADE, related_name = "profile")
    public_name = models.CharField(max_length=150, unique=True)
    private_name = models.CharField(max_length=150, blank=True, null=True)
    bio = models.TextField(blank=True, null=True)
    date_of_birth = models.DateField()
    profile_picture = models.ImageField(upload_to='profile_pictures/', blank=True, null=True)
    background_image = models.ImageField(upload_to='background_images/', blank=True, null=True)

class Friendship(models.Model):
    creator = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='created_friendships')
    friend = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='received_friendships')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['creator', 'friend'], name='unique_friendship')
        ]

    def __str__(self):
        return f"{self.creator} is friends with {self.friend}"
   
class FriendRequest(models.Model):
    from_user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="sent_friend_requests")
    to_user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="received_friend_requests")
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=10, choices=(('pending', 'Pending'), ('accepted', 'Accepted'), ('declined', 'Declined')), default='pending')

    class Meta:
        unique_together = (('from_user', 'to_user'),)
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.from_user} to {self.to_user} - {self.status}"
