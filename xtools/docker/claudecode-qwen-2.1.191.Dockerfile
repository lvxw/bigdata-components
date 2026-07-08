FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

ARG CLAUDE_VERSION="2.1.191"
ARG NODE_VERSION="v24.18.0"
ARG CUSTOM_MODE_ID="qwen3.7-max-2026-06-08"

RUN wget -P /usr/local/src/ https://nodejs.org/dist/latest-v24.x/node-${NODE_VERSION}-linux-x64.tar.gz && \
    tar -zxvf /usr/local/src/node-${NODE_VERSION}-linux-x64.tar.gz -C /opt/ && \
    rm -rf /usr/local/src/node-${NODE_VERSION}-linux-x64.tar.gz

ENV NODEJS_HOME=/opt/node-${NODE_VERSION}-linux-x64
ENV PATH="${NODEJS_HOME}/bin:/root/.local/bin:${PATH}"

COPY /dependency/claudecode-${CLAUDE_VERSION}/install.sh /usr/local/src/

RUN bash /usr/local/src/install.sh ${CLAUDE_VERSION}  && \
    rm -rf /usr/local/src/install.sh && \
    sed -i '$i\  ,"hasCompletedOnboarding": true' /root/.claude.json && \
    echo 'export PATH="${PATH}:/root/.local/bin"' >> /etc/profile && \
    echo 'export ANTHROPIC_BASE_URL=https://dashscope.aliyuncs.com/apps/anthropic' >> /etc/profile && \
    echo 'export ANTHROPIC_API_KEY=sk-ws-H.RYIXLHL.BZ0Z.MEYCIQDJkWOjI5wHBqq1mlutgLky2yoVbldIDX7IBVlluUgjKAIhAPHZFtY-Ob9OyatIkrYWbm6eSvyXucqI7-AKmWfRT_1f' >> /etc/profile && \
    echo "export ANTHROPIC_MODEL=${CUSTOM_MODE_ID}" >> /etc/profile

ENV PATH ${PATH}:/root/.local/bin
ENV ANTHROPIC_BASE_URL https://dashscope.aliyuncs.com/apps/anthropic
ENV ANTHROPIC_API_KEY sk-ws-H.RYIXLHL.BZ0Z.MEYCIQDJkWOjI5wHBqq1mlutgLky2yoVbldIDX7IBVlluUgjKAIhAPHZFtY-Ob9OyatIkrYWbm6eSvyXucqI7-AKmWfRT_1f
ENV ANTHROPIC_MODEL ${CUSTOM_MODE_ID}

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
