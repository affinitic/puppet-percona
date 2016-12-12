class percona::server::config {

  $mysql_version = $percona::mysql_version
  $mysqlserverid = $percona::mysql_serverid

  case $::osfamily {
    'Debian': {
      $my_file='/etc/mysql/my.cnf'
    }
    default: {
	$my_file='/etc/my.cnf'
    }
  }

  file {
    $my_file:
                  ensure  => present,
                  content => template('percona/my.cnf.erb'),
  }


 if "$percona::mysql_root_password" != undef {
   $root_password = $percona::mysql_root_password 
   case $percona::mysql_old_root_password {
     undef   : { $old_pwd = '' }
     default : { $old_pwd = "-p'${mysql_old_root_password}'" }
   }
 }

 exec { 'set_root_pwd':
        command   => "mysqladmin -u root ${old_pwd} password '${root_password}'",
        logoutput => true,
        unless    => "mysqladmin -u root -p'${root_password}' status > /dev/null",
        path      => '/usr/local/sbin:/usr/bin:/usr/local/bin',
        require   => Service['mysql'],
 }

 file { '/root/.my.cnf':
     ensure  => present,
     content => template("percona/rootmy.cnf.erb")
 }

}
