# Use Hadoop as the base image.
# Since Sqoop requires Hadoop to be running in the background.
FROM ghcr.io/kasipavankumar/hadoop-docker:latest

# Set working directory to / (home).
WORKDIR /

# Install required dependencies & remove apt cache.
RUN apt-get update && apt-get install -y \
    unzip \
    mysql-server \
    && rm -rf /var/lib/apt/lists/*

# Download & uncompress Apache Sqoop v1.4.7.
RUN wget -qO- http://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz | tar xvz

# Rename the directory "sqoop" for easy reference.
RUN mv sqoop-1.4.7.bin__hadoop-2.6.0 sqoop

# Set SQOOP_HOME.
ENV SQOOP_HOME=/sqoop

# Update PATH with Sqoop's bin.
ENV PATH=$PATH:${SQOOP_HOME}/bin

# Download & decompress MySQL connector.
RUN wget -qO- http://ftp.ntu.edu.tw/MySQL/Downloads/Connector-J/mysql-connector-java-8.0.26.tar.gz | tar xvz

# Move MySQL connector to Sqoop's lib directory.
RUN mv mysql-connector-java-8.0.26/mysql-connector-java-8.0.26.jar $SQOOP_HOME/lib \
    && rm -rf mysql-connector-java-8.0.26

# Download the commons lang.
RUN wget https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar

# Move commons lang to Sqoop's lib.
RUN mv commons-lang-2.6.jar $SQOOP_HOME/lib

# Download & unzip a sample database.
# https://dev.mysql.com/doc/employee/en/employees-installation.html
RUN wget https://github.com/datacharmer/test_db/archive/refs/heads/master.zip \
    && unzip master.zip

# Rename sqoop-env-template.sh → sqoop-env.sh.
RUN mv $SQOOP_HOME/conf/sqoop-env-template.sh $SQOOP_HOME/conf/sqoop-env.sh

# Edit Hadoop variables in "sqoop-env.sh".
RUN echo "export HADOOP_COMMON_HOME=/hadoop-3.3.1" >> $SQOOP_HOME/conf/sqoop-env.sh
RUN echo "export HADOOP_MAPRED_HOME=/hadoop-3.3.1" >> $SQOOP_HOME/conf/sqoop-env.sh

# Copy required files to the image.
COPY init.sh create_user.sql /

# Set permissions to execute scripts files.
RUN chmod 700 ./bootstrap.sh ./create_user.sql

CMD [ "bash", "./init.sh" ]
