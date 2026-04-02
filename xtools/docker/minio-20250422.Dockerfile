FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

ARG MINIO_VERSION="20250422"

RUN curl -Lo /usr/local/bin/minio https://dl.min.io/server/minio/release/linux-amd64/archive/minio.RELEASE.2025-04-22T22-12-26Z && \
    curl -Lo /usr/local/bin/mc https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.2025-04-16T18-13-26Z

RUN chmod 755 /usr/local/bin/minio /usr/local/bin/mc && \
    mkdir -p /data/minio ~/minio/logs

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'export MINIO_ROOT_USER=admin' >> /usr/local/bin/enterpoint.sh && \
    echo 'export MINIO_ROOT_PASSWORD=admin123456' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup minio server /data/minio  --console-address ":9090" > ~/minio/logs/minio.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet minio 9000 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check minio sleep ......" >> ~/minio/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mc alias set minio http://minio:9000 admin admin123456' >> /usr/local/bin/enterpoint.sh && \
    echo 'mc mb minio/bigdata' >> /usr/local/bin/enterpoint.sh && \
    echo 'mc mb minio/test' >> /usr/local/bin/enterpoint.sh && \
    echo 'mc cp /root/.bashrc minio/test/' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]