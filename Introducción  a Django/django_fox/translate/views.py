from django.shortcuts import render

def index(request):
    return render(request, 'index.html')


def otherview(request):
    return render(request, 'otherview.html')

def mainview(req):
    return render(req, "main.html")