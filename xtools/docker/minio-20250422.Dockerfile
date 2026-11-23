# dl.min.io stopped serving community binaries (HTTP 410) after the MinIO open-source project was archived,
# so build the pinned releases from the GitHub source tags instead.
FROM docker.io/library/golang:1.24 AS builder

ARG MINIO_TAG="RELEASE.2025-04-22T22-12-26Z"
ARG MC_TAG="RELEASE.2025-04-16T18-13-26Z"
ARG GOPROXY="https://goproxy.cn,https://proxy.golang.org,direct"
ENV GOPROXY=${GOPROXY} CGO_ENABLED=0 MINIO_RELEASE=RELEASE

# tag RELEASE.2025-04-22T22-12-26Z -> version 2025-04-22T22:12:26Z (same ldflags as the official release build)
RUN git clone --depth 1 --branch ${MINIO_TAG} https://github.com/minio/minio.git /src/minio && \
    cd /src/minio && \
    VER=$(echo ${MINIO_TAG#RELEASE.} | sed -E 's/T([0-9]{2})-([0-9]{2})-([0-9]{2})Z/T\1:\2:\3Z/') && \
    go build -tags kqueue -trimpath --ldflags "$(go run buildscripts/gen-ldflags.go ${VER})" -o /out/minio

RUN git clone --depth 1 --branch ${MC_TAG} https://github.com/minio/mc.git /src/mc && \
    cd /src/mc && \
    VER=$(echo ${MC_TAG#RELEASE.} | sed -E 's/T([0-9]{2})-([0-9]{2})-([0-9]{2})Z/T\1:\2:\3Z/') && \
    go build -tags kqueue -trimpath --ldflags "$(go run buildscripts/gen-ldflags.go ${VER})" -o /out/mc

FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

ARG MINIO_VERSION="20250422"

COPY --from=builder /out/minio /out/mc /usr/local/bin/

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