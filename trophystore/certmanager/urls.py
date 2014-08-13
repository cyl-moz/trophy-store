from django.conf.urls.defaults import *

from . import views


urlpatterns = patterns('',
    url(r'^$', views.index, name='certmanager.index'),
    url(r'^foo/$', views.foo, name='certmanager.foo'),
    url(r'^browserid/', include('django_browserid.urls')),
    url(r'^logout/?$', 'django.contrib.auth.views.logout', {'next_page': '/'},
        name='certmanager.logout'),
)
