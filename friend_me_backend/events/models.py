from django.db import models
from django.conf import settings
import uuid

class Event(models.Model):
    id = models.AutoField(primary_key=True)
    UID = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        default=0,
        related_name='created_events'
    )
    title = models.CharField(max_length=50)
    description = models.TextField(null=True)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title

    class Meta:
        db_table = "event"