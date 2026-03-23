from docker.io/oceanbase/oceanbase-ce:4.5.0.0-100000012025112711

RUN echo "fs.aio-max-nr=1048576" >> /etc/sysctl.conf && \
    echo -e "* soft nofile 20000\n* hard nofile 20000" >> /etc/security/limits.d/nofile.conf
