FROM base/archlinux
MAINTAINER Justin Buchanan <justbuchanan@gmail.com>

# update/init keyring
RUN pacman-key --init
RUN pacman-key --populate archlinux

# update keyring
RUN pacman --noconfirm -Sy archlinux-keyring

# update packages
RUN pacman -Syyu --noconfirm

# upgrade db
RUN pacman-db-upgrade

# install deps
RUN pacman -S --noconfirm python fakeroot sudo

# build user
# https://www.reddit.com/r/archlinux/comments/6qu4jt/how_to_run_makepkg_in_docker_container_yes_as_root/
RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers # Allow the builduser passwordless sudo

# install anaconda
RUN mkdir /anaconda
WORKDIR /anaconda
RUN chown builduser /anaconda
RUN sudo -u builduser curl "https://aur.archlinux.org/cgit/aur.git/plain/anaconda.install?h=anaconda" -o anaconda.install
RUN sudo -u builduser curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=anaconda" -o PKGBUILD
RUN PKGEXT=.tar sudo -E -u builduser makepkg && echo done
RUN ls -l
RUN pacman -S anaconda-5*.tar

# cadquery
RUN conda install -c pythonocc -c oce -c conda-forge -c dlr-sc -c CadQuery cadquery-occ

# Render test model to ensure things work
RUN python render.py output.stl

