"""backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns

from backend import views

urlpatterns = [
    url(r"^api/health", views.Health.as_view(), name="health"),
    url(r"^api/script/(?P<id>\d+)$", views.Script.as_view(), name="script"),
    url(r"^api/script$", views.Script.as_view(), name="script"),
    url(r"^api/port$", views.Port.as_view(), name="port"),
]