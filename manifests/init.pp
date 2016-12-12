class percona ($mysql_root_password=undef,$mysql_old_root_password=undef, $mysql_version='5.5', $mysql_serverid=undef, $ensure='running', $bootstrap=undef, $galera_version=2,  $mysql_bind_interface='eth0', $mysql_wsrep_cluster_address='gcomm://') {


        $mysql_ip = '0.0.0.0'
        info("Interface to use = ${mysql_bind_interface} and has IP ${mysql_ip}")


        include percona::repository

	info("LA VERSION EST ${$percona::mysql_version}")
}
