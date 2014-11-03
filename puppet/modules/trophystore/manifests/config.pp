class trophystore::config inherits trophystore {
    file { '/opt/trophy-store/trophystore/settings/local.py':
        owner => 'root',
        group => 'apache',
        mode => '0640',
        content => template('trophystore/local.py.erb'),
        require => Class['apache'],
    }
    
    file { '/etc/trophystore.yaml.dist':
        owner => 'root',
        group => 'root',
        mode => '0640',
        source => 'puppet:///modules/trophystore/etc/trophystore.yaml.dist'
    }

    class { 'apache::mod::wsgi':
        wsgi_python_home   => '/opt/trophy-store/.virtualenv/',
        wsgi_python_path   => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages',
    }

    include 'apache::mod::ssl'

    apache::vhost { 'trophystore.opsec.allizom.org':
        port    => '443',
        docroot => '/opt/trophy-store/wsgi/',  #???
        ssl => true,
        wsgi_application_group      => '%{GLOBAL}',
        wsgi_daemon_process         => 'trophystore',
        wsgi_daemon_process_options => { 
            processes    => '2', 
            threads      => '15', 
            display-name => '%{GROUP}',
        },
        wsgi_import_script          => '/opt/trophy-store/wsgi/playdoh.wsgi',
        wsgi_import_script_options  =>
            { process-group => 'trophystore', application-group => '%{GLOBAL}' },
        wsgi_process_group          => 'trophystore',
        wsgi_script_aliases         => { '/' => '/opt/trophy-store/wsgi/playdoh.wsgi' },
    }

}