FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

ARG CLAUDE_VERSION="2.1.191"

COPY /dependency/claudecode-${CLAUDE_VERSION}/install.sh /usr/local/src/

RUN bash /usr/local/src/install.sh ${CLAUDE_VERSION}  && \
    rm -rf /usr/local/src/install.sh && \
    sed -i '$i\  ,"hasCompletedOnboarding": true' /root/.claude.json && \
    echo 'export PATH="/root/.local/bin:${PATH}"' >> /etc/profile && \
    echo 'export ANTHROPIC_BASE_URL=https://dashscope.aliyuncs.com/apps/anthropic' >> /etc/profile && \
    echo 'export ANTHROPIC_API_KEY=sk-ws-H.RYIXLHL.BZ0Z.MEYCIQDJkWOjI5wHBqq1mlutgLky2yoVbldIDX7IBVlluUgjKAIhAPHZFtY-Ob9OyatIkrYWbm6eSvyXucqI7-AKmWfRT_1f' >> /etc/profile && \
    echo 'export ANTHROPIC_MODEL=qwen3.7-max' >> /etc/profile

ENV PATH "/root/.local/bin:${PATH}"

ENV ANTHROPIC_BASE_URL https://dashscope.aliyuncs.com/apps/anthropic
ENV ANTHROPIC_API_KEY sk-ws-H.RYIXLHL.BZ0Z.MEYCIQDJkWOjI5wHBqq1mlutgLky2yoVbldIDX7IBVlluUgjKAIhAPHZFtY-Ob9OyatIkrYWbm6eSvyXucqI7-AKmWfRT_1f
ENV ANTHROPIC_MODEL qwen3.7-max

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
