from django.contrib import admin
from django.urls import path
from products.views import index
from django.conf import settings
from django.conf.urls.static import static



urlpatterns = [
    #    path('/', include('products.url')),
    path('', index),
    path("admin", admin.site.urls),
] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)