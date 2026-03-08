FROM 10.10.52.13:5000/kasmweb/desktop:1.15.0-rolling

ARG DESKTOP_VERSION="1.15.0"
ARG IDEA_VERSION="2025.3.3"
ARG MAVEN_VERSION="3.8.9"
ARG SCALA_VERSION="2.12.8"
ARG NODE_VERSION="v24.14.0"

USER root

COPY /dependency/common/sources.list /etc/apt/

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FD533C07C264648F && \
    apt-get update && \
    apt-get install -y nfs-common sudo openjdk-8-jdk wget iputils-ping  telnet rsync language-pack-zh-hans openssh-server tree dos2unix netcat curl && \
    apt-get clean && \
    echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    rm -rf /var/lib/apt/list/* && \
    sed  -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config && \
    echo "root:root" | chpasswd && \
    mkdir -p /root/.ssh

RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli && \
    apt-get clean


RUN apt-get  install -y xrdp xfce4 xfce4-goodies && \
    apt-get clean && \
    sed -i 's/^port=3389/port=3391/' /etc/xrdp/xrdp.ini && \
    sed -i '28i\unset DBUS_SESSION_BUS_ADDRESS\nunset XDG_RUNTIME_DIR' /etc/xrdp/startwm.sh

ENV LANG C.UTF-8
ENV LANGUAGE zh_CN:zh
ENV TZ Asia/Shanghai

COPY /dependency/desktop-${DESKTOP_VERSION}/generate_container_user /dockerstartup/

RUN wget -P /usr/local/src/ https://download-cdn.jetbrains.com/idea/idea-${IDEA_VERSION}.tar.gz && \
    wget -P /usr/local/src/ https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    wget -P /usr/local/src/ https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz && \
    wget -P /usr/local/src/ https://nodejs.org/dist/latest-v24.x/node-${NODE_VERSION}-linux-x64.tar.gz && \
    tar -zxvf /usr/local/src/idea-${IDEA_VERSION}.tar.gz -C /opt/ && \
    tar -zxvf /usr/local/src/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt/ && \
    tar -zxvf /usr/local/src/scala-${SCALA_VERSION}.tgz -C /opt/ && \
    tar -zxvf /usr/local/src/node-${NODE_VERSION}-linux-x64.tar.gz -C /opt/ && \
    rm -rf /usr/local/src/idea-${IDEA_VERSION}.tar.gz /usr/local/src/apache-maven-${MAVEN_VERSION}-bin.tar.gz /usr/local/src/scala-${SCALA_VERSION}.tgz /usr/local/src/node-${NODE_VERSION}-linux-x64.tar.gz && \
    dos2unix /dockerstartup/generate_container_user


USER 1000

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV MAVEN_HOME /opt/apache-maven-${MAVEN_VERSION}
ENV NODEJS_HOME /opt/node-${NODE_VERSION}-linux-x64
ENV SCALA_HOME /opt/scala-${SCALA_VERSION}
ENV PATH ${PATH}:${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${NODEJS_HOME}/bin:${SCALA_HOME}/bin

RUN mkdir -p /home/kasm-user/Desktop && \
    echo '[Desktop Entry]' > /home/kasm-user/Desktop/idea.desktop && \
    echo 'Name=IntelliJ IDEA' >> /home/kasm-user/Desktop/idea.desktop && \
    echo 'Comment=IntelliJ IDEA' >> /home/kasm-user/Desktop/idea.desktop && \
    echo 'Exec=/opt/idea-IU-253.31033.145/bin/idea.sh' >> /home/kasm-user/Desktop/idea.desktop && \
    echo 'Icon=/opt/idea-IU-253.31033.145/bin/idea.png' >> /home/kasm-user/Desktop/idea.desktop && \
    echo 'Terminal=false' >> /home/kasm-user/Desktop/idea.desktop && \
    echo 'Type=Application' >> /home/kasm-user/Desktop/idea.desktop && \
    echo 'Categories=Developer;' >> /home/kasm-user/Desktop/idea.desktop


RUN mkdir -p /home/kasm-user/.config/xfce4/terminal/

COPY /dependency/desktop-${DESKTOP_VERSION}/terminalrc /home/kasm-user/.config/xfce4/terminal/

RUN sudo chown -R kasm-user:kasm-user /home/kasm-user

