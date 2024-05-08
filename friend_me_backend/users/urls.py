from django.urls import path, include
from .views import SignupView, LoginView
from users import views

urlpatterns = [
    path('signup/', SignupView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    path('usersdetails/', views.usersdetails, name='usersdetails')
]