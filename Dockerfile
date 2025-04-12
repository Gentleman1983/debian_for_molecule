ARG VERSION
FROM debian:${VERSION}
RUN apt-get update
RUN apt-get install --no-install-recommends -y systemd systemd-sysv
RUN rm -rf /etc/systemd/system/*.wants/* ; \
    rm -rf /lib/systemd/system/local-fs.target.wants/* ; \
    rm -rf /lib/systemd/system/multi-user.target.wants/* ; \
    rm -rf /lib/systemd/system/sockets.target.wants/*udev* ; \
    rm -rf /lib/systemd/system/sockets.target.wants/*initctl* ; \
    rm -rf /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* ; \
    rm -rf /lib/systemd/system/systemd-update-utmp*
RUN apt-get install -y python3 python3-apt
RUN apt-get install --no-install-recommends -y sudo openssh-server iproute2 apt
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*  /var/cache/apt/* /tmp/* /var/tmp/* ; \
    rm -rf /var/log/dpkg.log /var/log/apt/* /var/cache/debconf/* ;
RUN ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -P ''
RUN cp /root/.ssh/id_ed25519.pub /root/.ssh/authorized_keys
#RUN chmod 600 /root/.ssh/*
CMD ["/lib/systemd/systemd"]
