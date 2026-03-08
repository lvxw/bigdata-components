FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

ARG OLLAMA_VERSION="v0.17.7"

RUN mkdir -p /usr/local/ollama-${OLLAMA_VERSION} && \
    wget -P /usr/local/src/ https://github.com/ollama/ollama/releases/download/${OLLAMA_VERSION}/ollama-linux-amd64.tar.zst && \
    tar --zstd -xvf /usr/local/src/ollama-linux-amd64.tar.zst -C /usr/local/ollama-${OLLAMA_VERSION} && \
    rm -rf /usr/local/src/ollama-linux-amd64.tar.zst

RUN echo "export OLLAMA_HOME=/usr/local/ollama-${OLLAMA_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${OLLAMA_HOME}/bin' >> /etc/profile

ENV OLLAMA_HOME /usr/local/ollama-${OLLAMA_VERSION}
ENV PATH ${PATH}:${OLLAMA_HOME}/bin


