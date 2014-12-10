# == Class: trophystore
#
# Full description of class trophystore here.
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
class trophystore (
        $db_password = undef,
        $db_user = 'trophystore_user',
        $hmac_secret = undef,
        $django_secret = undef,
        $ssl_cert_content = undef,
        $ssl_key_content = undef,
        $ssl_chain_content = undef,
        $site_name = 'trophystore.opsec.allizom.org',
        $app_config = undef,
        ) {
    anchor { 'trophystore::begin': } ->
    class { '::trophystore::install': } ->
    class { '::trophystore::config': } ~>
    class { '::trophystore::service': } ->
    anchor { 'trophystore::end': }
}
