class mysql {
	package {'mysql':
		ensure => 'installed',
		provider => 'yum',
	}

	package {'mysql-server':
		ensure => 'installed',
		provider => 'yum',
	}
	
	service {'mysqld':
		ensure => 'running',
		provider => 'init',
		enable => 'true',
		hasrestart => 'true',
		require => Package['mysql-server']
	}

}
