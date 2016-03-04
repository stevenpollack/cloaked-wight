#!/bin/bash

echo "starting install_jdk_and_postgres_driver.sh..."

echo "installing open JDK 7 ..."
sudo apt-get install -y openjdk-7-jdk > /dev/null

cat >> ~/.zshrc << END
# add Java to path
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk
export PATH=\$JAVA_HOME/bin:\$PATH

END

echo "wget'ing postgresql-8.4-703.jdbc4.jar into" /home/$(whoami)/redshift_jdbc_jar "..."
mkdir ~/redshift_jdbc_jar
wget -P ~/redshift_jdbc_jar https://jdbc.postgresql.org/download/postgresql-8.4-703.jdbc4.jar

echo "install_jdk_and_postgres_driver.sh: done..."
