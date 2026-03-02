FROM 10.10.52.13:5000/lakehouse/docker:28.1.1

RUN apt-get update && \
    apt-get -y install podman kmod && \
    apt-get clean

ARG COMPONENT_VERSION="1.18.1"

ADD /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_1.18.1.tar.gz /usr/local/src/
COPY /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_service_images_amd64_1.18.1.tar.gz /usr/local/src/
COPY /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_workspace_images_amd64_1.18.1.tar.gz /usr/local/src/
COPY /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_logging_plugin_images_amd64_1.18.1.tar.gz /usr/local/src/
COPY /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_network_plugin_images_amd64_1.18.1.tar.gz /usr/local/src/

COPY /dependency/workspaces-${COMPONENT_VERSION}/workspaces.service /etc/systemd/system/
COPY /dependency/workspaces-${COMPONENT_VERSION}/workspaces_install.sh /usr/local/src/

RUN sed -i 's/sudo service docker restart/sleep 10s; sudo service docker restart/' /usr/local/src/kasm_release/install.sh && \
    ln -sf /etc/systemd/system/workspaces.service /etc/systemd/system/multi-user.target.wants/workspaces.service



