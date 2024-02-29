from django.db import models

# Create your models here.
from django.db import models
from django.conf import settings

class UserSchedule(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='schedule')
    events = models.ManyToManyField('events.Event', related_name='participants')
