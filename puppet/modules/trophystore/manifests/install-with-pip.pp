class trophystore::install-with-pip inherits trophystore {

    # Normally these dependencies are handled with the vendor submodule
    # Which you get by using the "--recursive" argument when you clone trophy-store
    #
    # git clone --recursive https://github.com/gene1wood/trophy-store /opt/trophy-store
    #
    # If you don't do that, you can add these into the virtualenv with pip
    #
    # http://playdoh.readthedocs.org/en/latest/packages.html#the-vendor-library

    package { 'gcc':}

    exec {'/opt/trophy-store/.virtualenv/bin/pip install funfactory':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/funfactory',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install Django==1.5.6':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/django',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install django_sha2':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/django_sha2',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install git+git://github.com/jbalogh/django-multidb-router.git@v0.5.1':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/multidb',
        require => Exec['create virtualenv'],
    }

    exec {'/opt/trophy-store/.virtualenv/bin/pip install git+git://github.com/mozilla/django-mozilla-product-details':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/product_details',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install django-session-csrf':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/session_csrf',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install django_nose':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/django_nose',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install django-celery':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/djcelery',
        require => [Exec['create virtualenv'],
                    Package['gcc'] ]
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install commonware':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/commonware',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install git+git://github.com/mozilla/django-browserid.git@v0.11':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/django_browserid',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install django-cronjobs':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/cronjobs',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install tower':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/tower',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install Babel':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/babel',
        require => Exec['create virtualenv'],
    }

    exec {'/opt/trophy-store/.virtualenv/bin/pip install django_compressor':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/compressor',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install jingo':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/jingo',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install django-mobility':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/mobility',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install bleach':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/bleach',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install cef':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/cef.py',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install git+git://github.com/mozilla/nuggets.git':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/dictconfig.py',
        require => Exec['create virtualenv'],
    }
}