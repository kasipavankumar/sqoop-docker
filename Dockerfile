# Use Hadoop as the base image.
# Since Sqoop required Hadoop to be running in the background.
FROM ghcr.io/max-rocco/hadoop-docker:main

# Set working directory to / (home).
WORKDIR /

# Install required dependencies & remove apt cache.
RUN apt-get update && apt-get install -y \
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

# Download the commons lang
RUN wget -qO- https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar

# Move it to Sqoop's lib
RUN mv commons-lang-2.6.jar $SQOOP_HOME/lib

# Rename sqoop-env-template.sh → sqoop-env.sh
RUN mv $SQOOP_HOME/conf/sqoop-env-template.sh $SQOOP_HOME/conf/sqoop-env.sh

# Edit Hadoop variables in "sqoop-env.sh".
RUN echo "export HADOOP_COMMON_HOME=/hadoop-3.3.1" >> $SQOOP_HOME/conf/sqoop-env.sh
RUN echo "export HADOOP_MAPRED_HOME=/hadoop-3.3.1" >> $SQOOP_HOME/conf/sqoop-env.sh

COPY init.sh /

RUN chmod 700 ./bootstrap.sh

CMD [ "bash", "./init.sh" ]
