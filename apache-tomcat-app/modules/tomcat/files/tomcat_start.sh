#!/bin/bash
instances="A B"

for i in $instances
do

#JAVA_HOME=/usr/java
JAVA_OPTS="-Xmx256m -Xms256m"
CATALINA_HOME=/opt/tomcat/apache-tomcat-7.0.75
CATALINA_BASE=/opt/tomcat/tomcat$i
export JAVA_HOME JAVA_OPTS CATALINA_HOME CATALINA_BASE

case $1 in
start)
$CATALINA_HOME/bin/catalina.sh start
sleep 5;
;;
stop)
$CATALINA_HOME/bin/catalina.sh stop
sleep 5;
;;
esac

done
