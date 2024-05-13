from django.contrib import admin
from django.urls import path, include
from events import views
from rest_framework import routers


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/profiles/', include('profiles.urls')),
    path('api/users/', include('users.urls')),
    path('', include('events.urls')),
    path('', include('users.urls')),
    path('', include('profiles.urls'))
]

