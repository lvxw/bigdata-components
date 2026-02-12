FROM docker.io/alluxio/alluxio:2.7.4

ENV LANG C.UTF-8

COPY conf/start-process.sh /usr/local/bin/

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start-process.sh"]