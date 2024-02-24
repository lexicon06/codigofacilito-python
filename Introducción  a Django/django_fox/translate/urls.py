from django.contrib import admin
from django.urls import path

from .views import index, otherview, mainview

urlpatterns = [
    path('', index),
    path("pov", otherview),
    path("main", mainview),
]