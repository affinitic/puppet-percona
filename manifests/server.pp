class percona::server  {

  include percona::server::packages
  include percona::server::config
  include percona::server::service

        #Class['percona::server::packages'] -> Class['percona::server::config'] ->  Class['percona::server::service']
        Class['percona::server::packages'] -> Class['percona::server::config'] 
}
