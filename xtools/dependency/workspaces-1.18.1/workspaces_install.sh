#!/bin/bash

/usr/local/src/kasm_release/install.sh --accept-eula --no-swap-check --proxy-port 8443 --offline-workspaces /usr/local/src/kasm_release_workspace_images_amd64_1.18.1.tar.gz --offline-service /usr/local/src/kasm_release_service_images_amd64_1.18.1.tar.gz --offline-network-plugin /usr/local/src/kasm_release_network_plugin_images_amd64_1.18.1.tar.gz --offline-logger-plugin /usr/local/src/kasm_release_logging_plugin_images_amd64_1.18.1.tar.gz > /usr/local/src/workerspace_install.log
