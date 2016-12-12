class percona::server::packages {

  $mysql_bin = 'mysql'


  case $::osfamily {
    default : {}
    'RedHat': {
        if "$percona::mysql_version" == "5.6" {
            info('Congrats ! Using 5.6 !!')
            $mysql_ver='56'
        } elsif "$percona::mysql_version" == '5.5' {
            info('You are conservative ! Using 5.5 !!')
            $mysql_ver='55'
        }
        else {
            info('Your are brave ! Using 5.7 !!')
            $mysql_ver='57'
        }
      $pack_server = "Percona-Server-server-${mysql_ver}"
      $pack_client = "Percona-Server-client-${mysql_ver}" 
      #$require = [ Yumrepo["ICINGA-release"], Package['Percona-Server-shared-compat'] ]
     }
    'Debian': {
      $pack_server = "percona-server-server-${percona::mysql_version}"
      $pack_client = "percona-server-client-${percona::mysql_version}"
      $require = Apt::Source['mysql-repo']
      info("Install ${packs}")
    }
  }
 

  package {
    $pack_client:
      ensure  => 'installed',
      alias => 'mysql-client',
      require => $require;
    $pack_server:
      ensure  => 'installed',
      require => [ $require, Package["$pack_client"] ];
    
  }

  

}
