FROM docker.io/motoserver/moto:5.2.3

ENV LANG C.UTF-8

RUN echo "export  LANG=C.UTF-8"  >> /etc/profile

ARG MOTO_VERSION="5.2.3"


run apk update && apk add --no-cache \
  curl \
  wget \
  vim \
  net-tools \
  iputils \
  jq \
  procps \
  bash \
  python3 py3-pip groff && \
  pip3 install awscli --break-system-packages && \
  pip install awscli

RUN echo "alias ll='ls -la'" >> /etc/profile.d/aliases.sh && \
    echo "alias ll='ls -la'" >> /root/.bashrc

