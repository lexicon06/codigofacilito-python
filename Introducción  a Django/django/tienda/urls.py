from django.contrib import admin
from django.urls import path
from .views import index, test, login

urlpatterns = [
    path("", index),
    path("yes", test),
    path("login", login)
]
