class percona::server::service {

  service {
    'mysql':
      ensure  => $percona::ensure,
      enable  => true,
      name    => $percona::server::packages::mysql_bin,
      require => Package[$percona::server::packages::packs],
  }

}
