# == Class: apache_vhost
#
# Installs and configures  Apache Vhost .
#
# All Rights Reserved.
#

class apache_vhost (
  $subdomains = []
)
   {


 class { 'apache':
    default_vhost       => false,
    default_mods        => false,
    default_confd_files => false,
  }

  include apache::mod::status
  
  include apache::mod::rewrite
  
   $subdomains.each |String $dbslave| {

    $servername = "$dbslave.xxx"

    

    apache::vhost { $servername:
      servername      => $servername,
      port            => '80',
      docroot         => '/var/www/html/',
      #access_log_file => "${servername}_access.log",
      #error_log_file  => "${servername}_error.log",
      access_log_pipe => "|/bin/logger -i -t ${dbslave}_80_a -p user.info",
      error_log_pipe  => "|/bin/logger -i -t ${dbslave}_80_e -p user.notice",
    }
    
    }
    
    
    





     include pkg::php
  include pkg::mysql::python
  include pkg::python::devel
  include pkg::wget

 class { 'pkg::python::psycopg2': }

 package { 'gd':
      ensure => $ensure,
    }
    
 # ----------------------------------------------------------------------------
# Add any additional settings *above* this comment block.
# ----------------------------------------------------------------------------

   
}



