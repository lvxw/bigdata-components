FROM 10.10.52.13:5000/lakehouse/claudecode-qwen:2.1.191

RUN curl -fsSL https://openclaw.ai/install.sh | OPENCLAW_VERSION=v2026.6.10 OPENCLAW_NO_PROMPT=1 OPENCLAW_NO_ONBOARD=1  bash

ARG CUSTOM_MODE_ID="qwen3.7-plus"

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw plugins install @openclaw/feishu" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw onboard --non-interactive --mode local --auth-choice custom-api-key --custom-base-url 'https://dashscope.aliyuncs.com/compatible-mode/v1' --custom-model-id '${CUSTOM_MODE_ID}' --custom-api-key 'sk-ws-H.RYIXLHL.BZ0Z.MEYCIQDJkWOjI5wHBqq1mlutgLky2yoVbldIDX7IBVlluUgjKAIhAPHZFtY-Ob9OyatIkrYWbm6eSvyXucqI7-AKmWfRT_1f' --custom-compatibility openai --secret-input-mode plaintext --install-daemon --accept-risk --skip-bootstrap --skip-skills" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw config set gateway.bind 'lan'" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw config set gateway.port 18790" >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set gateway.controlUi.allowedOrigins '"'"'["http://localhost:18790","http://127.0.0.1:18790","http://172.25.50.74:18790","http://hadoop:18790"]'"'"'' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set gateway.controlUi.dangerouslyDisableDeviceAuth true' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set gateway.auth.token a7f1c3e9b284d6a5e8c2b4a1f7d3e6c9b5a8d2f4e1c7b3a9d5f2e8b4c6a1d3f5' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set channels.feishu.enabled true' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set channels.feishu.appId cli_aa9afbf5efbadbdb' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set channels.feishu.appSecret o9ks2Ik46fYqrlPVWf8gUcDvolbFaRfd' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set channels.feishu.connectionMode websocket' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set channels.feishu.domain feishu' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set channels.feishu.groupPolicy allowlist' >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw config set channels.feishu.allowFrom '"'"'["ou_67c4eac9d2361b764e99040811acb149"]'"'"'' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup openclaw gateway run >> /tmp/openclaw.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]

#可以这样配置飞书插件， 但不需要了， 上面已经实现了
#openclaw channels login --channel feishu  (交互参数是：appId: cli_aa9afbf5efbadbdb  app_secret: o9ks2Ik46fYqrlPVWf8gUcDvolbFaRfd)
#netstat -tunlp  |  grep 18790 | awk '{print $7}' | awk -F '/' '{print $1}' |  xargs kill -9
#nohup openclaw gateway run >> /tmp/openclaw.log 2>&1 &