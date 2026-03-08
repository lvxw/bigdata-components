FROM 10.10.52.13:5000/lakehouse/ollama:0.17.7

ARG QWEN_VERSION="3.5"
ARG MODEL_paramter="0.8b"

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'export OLLAMA_HOST=0.0.0.0' >> /usr/local/bin/enterpoint.sh && \
    echo 'export OLLAMA_MODELS=/usr/local/src/models' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup ollama serve > /dev/null 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet 127.0.0.1 11434 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  echo "check ollama server ......"' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo "echo '/bye' |  ollama run qwen${QWEN_VERSION}:${MODEL_paramter}" >> /usr/local/bin/enterpoint.sh  && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]