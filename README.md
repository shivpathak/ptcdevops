Please find the guidlines below - 

1 - I have done setup apache, tomcat and MySQL on same box so I am always using localhost

2 - I am using mod_proxy_balancer to load balance traffic towards tomcat but we may can also use hardware load balancer which can ease the configuration.

3 - To start apache, tomcat and MySQL service we can set crontab like "@reboot <command to start the service>

4 - We can also enable service doing "chkconfig <httpd|mysql> on, or we can use "enable=>true" in puppet service definition it does internally chkconfig <service> on, and the other way to start service at server startup write control script and include in system rc.d to get it started at reboot.

5 - I have written 3 modules seperately for apache, tomcat and MySQL, these are very basic we can follow custom approach as well e.g. 

 i) we can compile apache and install compiled version in case we are working in non root environment.
 
6 - I have kept resource under files/templates directory under puppet modules.

7 - I have written startup script for tomcat to start two instance together which is found under files under tomcat module.

8 - I could have write better parameterized class to do more thing with little code but I need to think and need time.

9 - To test put apache, tomcat and mysql modules in puppet and assign to an node and run puppet client 

10 - That client box should have httpd, tomcat, mysqld service running and accessing apache should redirect to tomcat.

11 - To install Since except tomcat I am using yum to install apache, mysql so please maintain repository before running the puppet though this could also be include in precheck part in puppet.

12 - Please copy modules which are inside tarball on puppet server under modules directory.

13 - Assign class to puppet agent nodes on puppet master in site.pp or wherever appropriate which this needs to be tested as below - 

node '<node_name>', {
  include apache
  include tomcat
  include mysql
  }

Note - I couldn't used the payload pointed in exercise as that's actualy .ear file and deploying .ear file I think requires some extra configuration which I don't know at this point, I need to check that.
I have given very basic how we can reduce manual efforts but it could be made more easy and moduler by using other tools like SVN/Git, Jenkins etc.
