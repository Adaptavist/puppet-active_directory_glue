# == Class: active_directory_glue
#
# Authenticates Kerberos, joins a domain with Samba and configures SSSD.
#
# === Examples
#
#  include active_directory_glue
#
# === Authors
#
# Evgeny Zislis <ezislis@adaptavist.com>
#
# === Copyright
#
# Copyright 2014 Adaptavist Ltd, unless otherwise noted.
#
class active_directory_glue {

  include 'krb5'
  include 'samba'
  include 'sssd'

  class { 'krb5::authenticate': }
    -> class { 'samba::adsjoin::kerberos': }
    -> class { 'sssd::authconfig': }
    ~> Service[sssd]

}
