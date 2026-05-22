FROM 10.10.52.13:5000/lakehouse/claudecode:2.1.144

RUN curl -fsSL https://openclaw.ai/install.sh | OPENCLAW_VERSION=v2026.5.20 OPENCLAW_NO_PROMPT=1 OPENCLAW_NO_ONBOARD=1  bash

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw plugins install @openclaw/feishu" >> /usr/local/bin/enterpoint.sh && \
    echo 'openclaw onboard --non-interactive --mode local --auth-choice custom-api-key --custom-base-url "https://dashscope.aliyuncs.com/compatible-mode/v1" --custom-model-id "qwen3.6-plus" --custom-api-key "sk-890f55d8ca734843954290df53d4167a" --custom-compatibility openai --secret-input-mode plaintext --install-daemon --accept-risk --skip-bootstrap --skip-skills' >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw config set gateway.bind 'lan'" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw config set gateway.port 18790" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw config set gateway.auth.mode 'token'" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw config set gateway.auth.token 'a7f1c3e9b284d6a5e8c2b4a1f7d3e6c9b5a8d2f4e1c7b3a9d5f2e8b4c6a1d3f5'" >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup openclaw gateway run >> /tmp/openclaw.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '#要配置飞书，执行一下命令即可' >> /usr/local/bin/enterpoint.sh && \
    echo '#openclaw channels login --channel feishu  appId: cli_aa9afbf5efbadbdb  app_secret: o9ks2Ik46fYqrlPVWf8gUcDvolbFaRfd' >> /usr/local/bin/enterpoint.sh && \
    echo '#openclaw config set channels.feishu.allowFrom '"'"'["ou_67c4eac9d2361b764e99040811acb149"]'"'"' --json' >> /usr/local/bin/enterpoint.sh && \
    echo '#netstat -tunlp  |  grep 18790 | awk '"'"'{print $7}'"'"' | awk -F '"'"'/'"'"' '"'"'{print $1}'"'"' |  xargs kill -9' >> /usr/local/bin/enterpoint.sh && \
    echo '#nohup openclaw gateway run >> /tmp/openclaw.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]

