FROM ascdc/jdk8
WORKDIR /usr/local

ENV LANG C.UTF-8

RUN echo "export  LANG=C.UTF-8"  >> /etc/profile

RUN apt-get update && \
    apt-get -y install dos2unix net-tools iputils-ping telnet

ADD data/hadoop-3.1.4.tar.gz ./
ADD data/hbase-2.4.9-bin.tar.gz ./

RUN ln -s /usr/local/hadoop-3.1.4 /usr/local/hadoop && \
    ln -s /usr/local/hbase-2.4.9 /usr/local/hbase && \
    echo 'export HADOOP_HOME=/usr/local/hadoop' >> /root/.bashrc && \
    echo 'export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin' >> /root/.bashrc && \
    echo 'export HADOOP_CLASSPATH=`hadoop classpath`' >> /root/.bashrc && \
    echo 'export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop' >> /root/.bashrc && \
    echo 'export HBASE_HOME=/usr/local/hbase' >> /root/.bashrc && \
    echo 'export PATH=${PATH}:${HBASE_HOME}/bin' >> /root/.bashrc && \
    chown -R root:root /usr/local/hadoop-3.1.4 && \
    chown -R root:root /usr/local/hbase-2.4.9

COPY conf/core-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/hadoop-env.sh /usr/local/hadoop/etc/hadoop/
COPY conf/hdfs-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/mapred-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/yarn-env.sh /usr/local/hadoop/etc/hadoop/
COPY conf/yarn-site.xml /usr/local/hadoop/etc/hadoop/

COPY conf/hbase-site.xml /usr/local/hbase/conf/
COPY conf/hbase-env.sh /usr/local/hbase/conf/

COPY conf/start-process.sh /usr/local/bin/

RUN dos2unix /usr/local/hadoop/etc/hadoop/* /usr/local/hbase/conf/* /usr/local/bin/* && \
    chmod 755 /usr/local/bin/*

ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_CLASSPATH `hadoop classpath`
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV HBASE_HOME /usr/local/hbase
ENV PATH ${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${HBASE_HOME}/bin

RUN mkdir -p /data/tmp

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start-process.sh"]