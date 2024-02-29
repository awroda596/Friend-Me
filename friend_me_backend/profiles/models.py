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
