class tomcat {
	
	file {['/opt/tomcat', '/opt/tomcat/bin']:
		mode => '0755',
		ensure => 'directory',
	}

	file {'/opt/tomcat/bin/tomcat_start.sh':
		ensure => 'file',
		mode => '0755',
		source => "puppet:///modules/tomcat/tomcat_start.sh",
	}

	file {'/opt/tomcat/tomcatA/webapps/sample.war':
		mode => '0755',
		ensure => 'present',
		source => "puppet:///modules/tomcat/sample.war",
	}
	
	file {'/opt/tomcat/tomcatB/webapps/sample.war':
		mode => '0755',
		ensure => 'present',
		source => "puppet:///modules/tomcat/sample.war",
	}

	exec {'extract_tomcat7':
		path => ['/bin','/usr/bin','/sbin'],
		command => "tar -xzf /etc/puppet/modules/tomcat/files/apache-tomcat-7.0.75.tar.gz",
		cwd => "/opt/tomcat",
		require => File['/opt/tomcat'],
	}

	file {'/opt/tomcat/tomcatA':
		mode => '0755',
		ensure => 'directory',
		source => "puppet:///modules/tomcat/tomcatA",
		recurse => 'true',
	}

	file {'/opt/tomcat/tomcatB':
		mode => '0755',
		ensure => 'directory',
		source => "puppet:///modules/tomcat/tomcatB",
		recurse => 'true',
	}

	service {'tomcatA_tomcatB':
		hasrestart => 'false',
		ensure => "running",
		start => "/opt/tomcat/bin/tomcat_start.sh start",
		stop => "/opt/tomcat/bin/tomcat_start.sh stop",
		require => [File['/opt/tomcat/tomcatA/webapps/sample.war'],File['/opt/tomcat/tomcatB/webapps/sample.war'],File['/opt/tomcat/bin/tomcat_start.sh'],Exec['extract_tomcat7']],
		subscribe => [File['/opt/tomcat/tomcatA/webapps/sample.war'],File['/opt/tomcat/tomcatB/webapps/sample.war'],File['/opt/tomcat/bin/tomcat_start.sh'],Exec['extract_tomcat7']],
	
	}
}
