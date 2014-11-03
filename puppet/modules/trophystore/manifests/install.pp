# == Class: trophystore::install
#
# Full description of class trophystore::install here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { trophystore:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class trophystore::install inherits trophystore {

    # This assumes CentOS 7 where Python 2.7 is the default

    package { 'epel-release':
        source => 'http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm'
    }

    package { 'python-pip':
        require => Package['epel-release'],
    }

    package { 'virtualenv':
        provider => 'pip',
        require => Package['python-pip'],
    }
    exec {'create virtualenv':
        command => '/usr/bin/virtualenv /opt/trophy-store/.virtualenv',
        creates => '/opt/trophy-store/.virtualenv',
        require => Package['virtualenv'],
    }

    class { '::mysql::server':
        root_password => $db_root_password,
        users         => {
            "${db_user}@localhost" => {
                ensure                   => 'present',
                password_hash            => mysql_password($db_password)
            }
        },
        package_name => 'mariadb-server',
        service_name => 'mariadb',
        override_options => {
            'mysqld' => {
                'log-error' => '/var/log/mariadb/mariadb.log',
                'pid-file' => '/var/run/mariadb/mariadb.pid',
            },
            'mysqld_safe' => {
                'log-error' => '/var/log/mariadb/mariadb.log'
            },
        },
        databases => {
            'trophystore' => {
                ensure => 'present',
                charset => 'utf8',
            }
        },
        grants => {
            "${db_user}@localhost/trophystore.*" => {
                ensure     => 'present',
                options    => ['GRANT'],
                privileges => ['ALL'],
                table      => 'trophystore.*',
                user       => "${db_user}@localhost",
            }
        },
    }

    package { 'gcc':}
    package { 'python-devel':
        require => Package['gcc']
    }
    package { 'mariadb-devel':}
    package { 'libffi-devel':}
    package { 'openssl-devel':}
    package { 'libyaml-devel':}

    # The packages are installed into the virtualenv with `exec` in order to
    # work around https://tickets.puppetlabs.com/browse/PUP-1062

    exec {'/opt/trophy-store/.virtualenv/bin/pip install MySQL-python':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/MySQLdb',
        require => [Exec['create virtualenv'],
                    Class['mysql::server'],
                    Package['python-devel'] ]
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install python-bcrypt':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/bcrypt',
        require => [ Exec['create virtualenv'], 
                     Package['python-devel']],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install boto':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/boto',
        require => Exec['create virtualenv'],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install pyOpenSSL':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/OpenSSL',
        require => [ Exec['create virtualenv'], 
                     Package['libffi-devel'],
                     Package['gcc'],
                     Package['openssl-devel'] ],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install PyYAML':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/yaml',
        require => [ Exec['create virtualenv'], 
                     Package['gcc'],
                     Package['libyaml-devel'] ],
    }
    exec {'/opt/trophy-store/.virtualenv/bin/pip install jinja2':
        creates => '/opt/trophy-store/.virtualenv/lib/python2.7/site-packages/jinja2',
        require => [Exec['create virtualenv'],
                    Package['gcc'] ]
    }

    class { 'apache':
        default_mods        => false,
        default_confd_files => false,
    }

}
