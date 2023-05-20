FROM archlinux:base-devel

ARG SUDO_GROUP=wheel
ARG USERNAME=maverick
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN pacman-key --init
RUN pacman -Syu --noconfirm \
    sudo \
    make \
    man-db

RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN groupadd -g $USER_GID $USERNAME \
    && useradd -u $USER_UID -g $USER_GID -m $USERNAME -G $SUDO_GROUP -s /bin/bash 

USER $USERNAME
WORKDIR /home/$USERNAME/.local/share/chezmoi

