FROM 10.10.52.13:5000/lakehouse/claudecode-qwen:2.1.191

ARG HERMES_VERSION="2026.6.19"

COPY /dependency/hermes-${HERMES_VERSION}/install.sh /usr/local/src/

RUN bash /usr/local/src/install.sh  && \
    rm -rf /usr/local/src/install.sh

ARG CUSTOM_MODE_ID="qwen3.7-plus"

RUN hermes config set model.default ${CUSTOM_MODE_ID} && \
    hermes config set model.provider custom && \
    hermes config set model.base_url https://dashscope.aliyuncs.com/apps/anthropic && \
    hermes config set model.api_mode anthropic_messages && \
    hermes config set model.api_key sk-ws-H.RYIXLHL.BZ0Z.MEYCIQDJkWOjI5wHBqq1mlutgLky2yoVbldIDX7IBVlluUgjKAIhAPHZFtY-Ob9OyatIkrYWbm6eSvyXucqI7-AKmWfRT_1f && \
    hermes config set dashboard.basic_auth.username admin && \
    hermes config set dashboard.basic_auth.password_hash 'scrypt$16384$8$1$jwLoQoiiQU+FEZuxSxDGMA==$gyz+DitnkQWr6wIpgd7aiLSFhSzNTEPWsj8G2dszNjQ=' && \
    hermes config set dashboard.basic_auth.secret YcCwBZB07_Uan5NWyQU4JmtQwgqo5eUDKHNzEJn31kc && \
    hermes config set dashboard.basic_auth.session_ttl_seconds 0 && \
    echo 'FEISHU_APP_ID=cli_aab4a4d732349cde' >> /root/.hermes/.env && \
    echo 'FEISHU_APP_SECRET=YF4pj2djWactt6W6VSWnohBJ44TIpQre' >> /root/.hermes/.env && \
    echo 'FEISHU_DOMAIN=feishu' >> /root/.hermes/.env && \
    echo 'FEISHU_CONNECTION_MODE=websocket' >> /root/.hermes/.env && \
    echo 'FEISHU_ALLOW_ALL_USERS=true' >> /root/.hermes/.env && \
    echo 'FEISHU_GROUP_POLICY=open' >> /root/.hermes/.env

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'nohup hermes gateway run >> /tmp/hermes.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup hermes dashboard --host 0.0.0.0 --port 9119 --insecure --no-open  >> /tmp/dashboard.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]