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

    file { '/etc/trophystore.yaml':
        owner => 'root',
        group => 'root',
        mode => '0640',
        content => inline_template("<%= @app_config.to_yaml + '\n' %>")
    }

    class { 'apache::mod::wsgi':
        wsgi_python_home   => '/opt/trophy-store/.virtualenv/',
        wsgi_python_path   => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages',
    }

    include 'apache::mod::ssl'

    $ssl_keys_dir = dirname($::apache::default_ssl_key)
    $ssl_key_filename = "${ssl_keys_dir}/${site_name}.key"
    $ssl_cert_filename = "${::apache::ssl_certs_dir}/${site_name}.crt"
    $ssl_chain_filename = "${::apache::ssl_certs_dir}/${site_name}.chain.crt"

    if $ssl_cert_content {
        file { $ssl_cert_filename:
            owner => 'root',
            group => 'root',
            mode  => '0644',
            content => $ssl_cert_content,
        }
    }

    if $ssl_key_content {
        file { $ssl_key_filename:
            owner => 'root',
            group => 'root',
            mode  => '0600',
            content => $ssl_key_content,
        }
    }

    if $ssl_chain_content {
        file { $ssl_chain_filename:
            owner => 'root',
            group => 'root',
            mode  => '0644',
            content => $ssl_chain_content,
        }
    }

    apache::vhost { $site_name:
        port    => '443',
        docroot => '/opt/trophy-store/wsgi/',  #???
        ssl => true,
        ssl_cert => $ssl_cert_content ? {
            undef => undef,
            default => $ssl_cert_filename
        },
        ssl_chain => $ssl_chain_content ? {
            undef => undef,
            default => $ssl_chain_filename
        },
        ssl_key => $ssl_key_content ? {
            undef => undef,
            default => $ssl_key_filename
        },
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