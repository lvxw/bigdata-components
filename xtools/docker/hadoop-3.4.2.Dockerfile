FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG HADOOP_VERSION="3.4.2"

RUN apt-get update && \
    apt-get --purge remove -y openjdk-8-jdk-headless openjdk-8-jdk openjdk-8-jre-headless openjdk-8-jre && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}-lean.tar.gz && \
    tar zxvf /usr/local/src/hadoop-${HADOOP_VERSION}-lean.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/hadoop-${HADOOP_VERSION}-lean.tar.gz

COPY /dependency/hadoop-${HADOOP_VERSION}/core-site.xml /usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop/
COPY /dependency/hadoop-${HADOOP_VERSION}/hdfs-site.xml /usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop/
COPY /dependency/hadoop-${HADOOP_VERSION}/mapred-site.xml /usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop/
COPY /dependency/hadoop-${HADOOP_VERSION}/yarn-site.xml /usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop/
COPY /dependency/hadoop-${HADOOP_VERSION}/capacity-scheduler.xml /usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop/

RUN mkdir -p /data/hadoop/dfs/name /data/hadoop/dfs/data /data/hadoop/tmp && \
    sed -i 's/java-8-openjdk-amd64/java-17-openjdk-amd64/' /etc/profile && \
    echo "export HADOOP_HOME=/usr/local/hadoop-${HADOOP_VERSION}" >> /etc/profile && \
    echo "export HADOOP_CONF_DIR=/usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop" >> /etc/profile && \
    echo "export YARN_CONF_DIR=/usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin' >> /etc/profile && \
    echo 'export HADOOP_CLASSPATH=`hadoop classpath`' >> /etc/profile

ENV HADOOP_HOME /usr/local/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR /usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop
ENV YARN_CONF_DIR /usr/local/hadoop-${HADOOP_VERSION}/etc/hadoop
ENV PATH ${PATH}:${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin
ENV HADOOP_CLASSPATH ${HADOOP_HOME}/etc/hadoop:${HADOOP_HOME}/share/hadoop/common/lib/*:${HADOOP_HOME}/share/hadoop/common/*:${HADOOP_HOME}/share/hadoop/hdfs:${HADOOP_HOME}/share/hadoop/hdfs/lib/*:/usr/local/hadoop-3.1.4/share/hadoop/hdfs/*:${HADOOP_HOME}/share/hadoop/mapreduce/lib/*:${HADOOP_HOME}/share/hadoop/mapreduce/*:${HADOOP_HOME}/share/hadoop/yarn:${HADOOP_HOME}/share/hadoop/yarn/lib/*:/usr/local/hadoop-3.1.4/share/hadoop/yarn/*

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs namenode -format' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs --daemon start namenode' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs --daemon start datanode' >> /usr/local/bin/enterpoint.sh && \
    echo 'yarn --daemon start resourcemanager' >> /usr/local/bin/enterpoint.sh && \
    echo 'yarn --daemon start nodemanager' >> /usr/local/bin/enterpoint.sh && \
    echo 'mapred --daemon start historyserver' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]