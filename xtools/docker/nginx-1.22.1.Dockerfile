FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

ARG NGINX_VERSION="1.22.1"

RUN wget -P /usr/local/src/ http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar zxvf /usr/local/src/nginx-${NGINX_VERSION}.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/nginx-${NGINX_VERSION}.tar.gz

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install gcc make openssl libssl-dev libpcre3 libpcre3-dev libgd-dev && \
    apt-get clean

RUN cd /usr/local/nginx-${NGINX_VERSION} && \
     ./configure --prefix=/usr/local/nginx \
     --with-http_stub_status_module --with-http_ssl_module \
     --with-http_realip_module --with-http_gzip_static_module \
     --with-stream --with-stream_ssl_module \
     --with-file-aio --with-http_realip_module  &&  \
     make -j4 && \
     make -j4 install

ADD /dependency/nginx-${NGINX_VERSION}/ssl.tgz /usr/local/nginx/conf/

COPY /dependency/nginx-${NGINX_VERSION}/nginx.conf /usr/local/nginx/conf
COPY /dependency/nginx-${NGINX_VERSION}/start-process.sh /usr/local/bin/

RUN dos2unix /usr/local/nginx/conf /usr/local/bin/start-process.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start-process.sh"]

WORKDIR /usr/local/nginx

#mkdir -p /usr/local/nginx/conf/ssl/
#cd /usr/local/nginx/conf/ssl/
#openssl genrsa -out private.key 2048
#openssl req -new -key private.key -out cert_req.csr
#openssl x509 -req -days 365 -in cert_req.csr -signkey private.key -out server_cert.crt
