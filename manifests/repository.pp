class percona::repository {


  case $::osfamily {
    'RedHat': {
	$releasever = "7"
 	$basearch = $hardwaremodel
 	yumrepo {
        	"percona":
            		descr       => "Percona",
            		enabled     => 1,
            		baseurl     => "http://repo.percona.com/centos/$releasever/os/$basearch/",
            		gpgcheck    => 0;
	}
    }
    'Debian': {
      include ::apt
      exec {
        'apt-get update percona':
            command => '/usr/bin/apt-get update',
      }


      $repo_descr      = 'Percona'
      $repo_url        = 'http://repo.percona.com/apt/'
      $repo_repos      = 'main'
      $repo_release    = $::lsbdistcodename

      apt::source {
        'mysql-repo':
          location => $repo_url,
          release  => $repo_release,
          repos    => $repo_repos,
      }

      apt::key {
        '9334A25F8507EFA5':
          source  =>  'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9334A25F8507EFA5'
      }

    }
    default: { error('distribution not supported') }
  }
}
