from django.shortcuts import render

from .models import App

# Create your views here.
def index(request):
    return render(request, "index.html")


def test(request):
    data = App.objects.all()
    return render(request, "test.html", {'data': data})


def login(request):
    return render(request, "login.html")