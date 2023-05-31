FROM alpine:3.17

ENV VAGRANT_VERSION="v2.3.4"
ENV VAGRANT_DEFAULT_PROVIDER=libvirt

RUN apk update && apk add --no-cache \
    bash \
    vim \
    curl \
    git \
    jq \
    dpkg \
    openssh-client \
    openrc \
    qemu-img \
    qemu-modules \
    qemu-system-x86_64 \
    libvirt-daemon \
    libvirt \
    libvirt-qemu \
    ruby-bundler \
    ruby-dev \
    libarchive-tools \
    kmod \
    make \
    gcc \
    g++ \
    gcompat \
    libc6-compat \
    linux-headers \
    musl-dev \
    libvirt-dev 

RUN echo -e "max_client_requests = 5\n" >> /etc/libvirt/libvirtd.conf
RUN git clone --branch 0.12.0 https://github.com/vagrant-libvirt/vagrant-libvirt.git && \
    cd vagrant-libvirt && bundle install && bundle --binstubs exec
ENV PATH="$PATH:/vagrant-libvirt/exec"

# # https://wiki.alpinelinux.org/wiki/QEMU
RUN echo 'auto eth0' > /etc/network/interfaces
RUN echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.conf

# Install guest system
RUN mkdir /guest-system
COPY Vagrantfile /guest-system

ADD --chmod=755 startup.sh startup.sh

ENTRYPOINT ["/startup.sh"]