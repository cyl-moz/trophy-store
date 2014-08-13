import logging

from django.shortcuts import render

import bleach
import commonware
from funfactory.log import log_cef
from mobility.decorators import mobile_template
from session_csrf import anonymous_csrf


log = commonware.log.getLogger('playdoh')


# @mobile_template('examples/{mobile/}home.html')
def index(request, template='certmanager/home.html'):
    """Main view."""
    data = {}  # You'd add data here that you're sending to the template.
    log.debug("I'm alive!")
    return render(request, template, data)

def foo(request, template='certmanager/foo.html'):
    """Main view."""
    data = {}  # You'd add data here that you're sending to the template.
    log.debug("I'm alive!")
    return render(request, template, data)