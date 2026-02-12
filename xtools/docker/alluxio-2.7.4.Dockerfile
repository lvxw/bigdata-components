FROM docker.io/alluxio/alluxio:2.7.4

ENV LANG C.UTF-8

ARG ALLUXIO_VERSION="2.7.4"

COPY /dependency/alluxio-${ALLUXIO_VERSION}/start-process.sh /usr/local/bin/

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start-process.sh"]