FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

ARG CLAUDE_VERSION="2.1.63"

COPY /dependency/claudecode-${CLAUDE_VERSION}/install.sh /usr/local/src/

RUN bash /usr/local/src/install.sh && \
    rm -rf /usr/local/src/install.sh && \
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /etc/profile

ENV PATH "$HOME/.local/bin:$PATH"

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh \

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
