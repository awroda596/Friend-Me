from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserProfileViewSet
from profiles import views

router = DefaultRouter()
router.register(r'userprofiles', UserProfileViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('profilesdetails/', views.profilesdetails, name='profilesdetails')
]
