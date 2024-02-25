from django.contrib import admin
from django.urls import path
from .views import index, test

urlpatterns = [
    path("", index),
    path("yes", test),
]
