FROM 10.10.52.13:5000/lakehouse/docker:28.1.1

RUN apt-get update && \
    apt-get -y install podman && \
    apt-get clean

ARG COMPONENT_VERSION="1.18.1"

ADD /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_1.18.1.tar.gz /usr/local/src/
ADD /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_service_images_amd64_1.18.1.tar.gz /usr/local/src/kasm_release/
ADD /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_workspace_images_amd64_1.18.1.tar.gz /usr/local/src/kasm_release/
COPY /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_logging_plugin_images_amd64_1.18.1.tar.gz /usr/local/src/
COPY /dependency/workspaces-${COMPONENT_VERSION}/kasm_release_network_plugin_images_amd64_1.18.1.tar.gz /usr/local/src/

COPY /dependency/workspaces-${COMPONENT_VERSION}/workspaces.service /etc/systemd/system/
COPY /dependency/workspaces-${COMPONENT_VERSION}/workspaces_install.sh /usr/local/src/
COPY /dependency/workspaces-${COMPONENT_VERSION}/install.sh /usr/local/src/kasm_release/

RUN while IFS="" read -r image || [ -n "$image" ]; do IMAGE_FILENAME=$(echo $image | sed -r 's#[:/]#_#g') && podman load --input /usr/local/src/kasm_release/service_images/${IMAGE_FILENAME}.tar; done < /usr/local/src/kasm_release/service_images/images.txt && \
    while IFS="" read -r image || [ -n "$image" ]; do IMAGE_FILENAME=$(echo $image | sed -r 's#[:/]#_#g') && podman load --input /usr/local/src/kasm_release/workspace_images/${IMAGE_FILENAME}.tar; done < /usr/local/src/kasm_release/workspace_images/images.txt && \
    chmod 755 /usr/local/src/workspaces_install.sh && \
    ln -sf /etc/systemd/system/workspaces.service /etc/systemd/system/multi-user.target.wants/workspaces.service

