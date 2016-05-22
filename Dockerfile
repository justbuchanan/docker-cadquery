FROM base/archlinux
MAINTAINER Justin Buchanan <justbuchanan@gmail.com>

# update/init keyring
RUN pacman-key --init
RUN pacman-key --populate archlinux

# update keyring
RUN pacman --noconfirm -Sy archlinux-keyring

# update packages
RUN pacman -Syu --noconfirm

# upgrade db
RUN pacman-db-upgrade

# switch from https to http for mirror
# TODO: switch back to https
RUN sed -i 's/https/http/' /etc/pacman.d/mirrorlist

# clear package cache to save disk space
RUN pacman -Scc --noconfirm

