from django.db import models
from django.contrib.auth.models import AbstractUser


class CustomUser(AbstractUser):
    # can add additional fields as needed
    email = models.EmailField(unique = True)
