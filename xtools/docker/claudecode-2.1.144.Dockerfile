FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

ARG CLAUDE_VERSION="2.1.144"

COPY /dependency/claudecode-${CLAUDE_VERSION}/install.sh /usr/local/src/

RUN bash /usr/local/src/install.sh ${CLAUDE_VERSION}  && \
    rm -rf /usr/local/src/install.sh && \
    sed -i '$i\  ,"hasCompletedOnboarding": true' /root/.claude.json && \
    echo 'export PATH="/root/.local/bin:${PATH}"' >> /etc/profile && \
    echo 'export ANTHROPIC_BASE_URL=https://dashscope.aliyuncs.com/apps/anthropic' >> /etc/profile && \
    echo 'export ANTHROPIC_API_KEY=sk-890f55d8ca734843954290df53d4167a' >> /etc/profile && \
    echo 'export ANTHROPIC_MODEL=qwen3.6-plus' >> /etc/profile

ENV PATH "/root/.local/bin:${PATH}"

ENV ANTHROPIC_BASE_URL https://dashscope.aliyuncs.com/apps/anthropic
ENV ANTHROPIC_API_KEY sk-890f55d8ca734843954290df53d4167a
ENV ANTHROPIC_MODEL qwen3.6-plus

RUN curl -fsSL https://github.com/SaladDay/cc-switch-cli/releases/latest/download/install.sh | bash

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
