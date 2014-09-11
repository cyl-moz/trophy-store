from django.conf.urls.defaults import *

from . import views


urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    url(r'^request/$', views.request, name='request'),
    url(r'^display_list/$', views.display_list, name='display_list'),
    url(r'^display_cert/([0-9]+)/$', views.display_cert, name='display_cert'),
    url(r'^deploy/$', views.deploy, name='deploy'),
    url(r'^browserid/', include('django_browserid.urls')),
    url(r'^logout/?$', 'django.contrib.auth.views.logout', {'next_page': '/'},
        name='logout'),
)
