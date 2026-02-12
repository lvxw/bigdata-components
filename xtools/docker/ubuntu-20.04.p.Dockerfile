FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

RUN apt-get update && \
    apt-get -y install python3 pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    python -m pip install --upgrade pip && \
    pip install pip -U && \
    pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
