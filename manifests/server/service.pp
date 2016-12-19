class percona::server::service {

  service {
    'mysql':
      ensure  => $percona::ensure,
      enable  => true,
      name    => $percona::server::packages::mysql_bin,
      require => Package[$percona::server::packages::pack_client],
  }
      info("We need $percona::server::packages::pack_client")
}
