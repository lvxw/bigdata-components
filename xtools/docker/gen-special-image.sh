#docker pull ubuntu:20.04 && \
#docker pull kasmweb/desktop:1.15.0-rolling && \
#docker tag kasmweb/desktop:1.15.0-rolling 10.10.52.13:5000/kasmweb/desktop:1.15.0-rolling && \
#bash build.sh ubuntu 20.04.b && \
#bash build.sh ubuntu 20.04.j && \
#bash build.sh ubuntu 20.04.p && \
#bash build.sh mysql 5.7 && \
#bash build.sh zookeeper 3.6.3 && \
#bash build.sh kafka 1.1.1 && \
#bash build.sh hadoop 3.1.4 && \
#bash build.sh hive 3.1.2 && \
#bash build.sh pushgateway 1.6.2 && \
#bash build.sh hbase 2.4.9 && \
bash build.sh doris 2.0.2 && \
bash build.sh flink 1.19.2 && \
bash build.sh fluss 0.7.0 && \
bash build.sh dinky 1.2.3  && \
bash build.sh minio 20250422 && \
bash build.sh desktop 1.15.0 && \
docker-compose up -d dinky desktop
