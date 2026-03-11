FROM 10.10.52.13:5000/lakehouse/ubuntu:24.04.j

RUN apt update && \
    apt upgrade -y && \
    apt install ubuntu-desktop gnome-shell gnome-session gdm3 -y && \
    apt install xrdp -y && \
    apt-get clean
