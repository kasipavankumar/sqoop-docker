FROM ghcr.io/max-rocco/hadoop-docker:main

WORKDIR /

# Download Sqoop v1.4.7
RUN wget http://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz \
    && tar xzf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz

# Download MySQL connector
RUN wget http://ftp.ntu.edu.tw/MySQL/Downloads/Connector-J/mysql-connector-java-8.0.26.tar.gz \
    && tar xzf mysql-connector-java-8.0.26.tar.gz

# Rename to "sqoop"
RUN mv sqoop-1.4.7.bin__hadoop-2.6.0 sqoop

# Set SQOOP_HOME
ENV SQOOP_HOME=/sqoop

# Update PATH
ENV PATH=$PATH:${SQOOP_HOME}/bin

# Remove tarballs
RUN rm *.tar.gz

# Rename sqoop-env-template.sh → sqoop-env.sh
RUN mv $SQOOP_HOME/conf/sqoop-env-template.sh $SQOOP_HOME/conf/sqoop-env.sh

RUN echo "export HADOOP_COMMON_HOME=/hadoop-3.3.1" >> $SQOOP_HOME/conf/sqoop-env.sh
RUN echo "export HADOOP_MAPRED_HOME=/hadoop-3.3.1" >> $SQOOP_HOME/conf/sqoop-env.sh

CMD [ "bash", "./bootstrap.sh" ]
