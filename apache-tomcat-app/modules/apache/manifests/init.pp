class apache {

	package {'httpd':
	provider => 'yum',
	ensure => 'installed',
	}
	
	file {'/etc/httpd/conf.d/myvhosts.conf':
		mode => '0644',
		ensure => 'file',
		content => template('apache/myvhosts.conf.erb'),
		require => Package['httpd'],
	}
	
	service {'httpd':
		provider => 'init',
		ensure => 'running',
		hasrestart => 'true',
		require => File['/etc/httpd/conf.d/myvhosts.conf'],
		subscribe => File['/etc/httpd/conf.d/myvhosts.conf']
	}
}
