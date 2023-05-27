Build Docker container
=====

`$> docker build -t win-in-docker .`


Run the container and build the box
======

`$> docker run --privileged -it --device=/dev/kvm --device=/dev/net/tun -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cap-add=NET_ADMIN --cap-add=SYS_ADMIN win-in-docker /bin/bash`

`$> cd guest-system`
`$> vagrant up` (and waaaait :wink: )


Prepare host
=====

`$> sudo su modprobe ip6table_filter`

Connect to remote machine
====

* Establish an ssh tunnel to your docker host

    `$> ssh -L 33389:<IP_OF_CONTAINER>:3389 -l <LOGIN> <DOCKER_HOST>`

    * `IP_OF_CONTAINER`: Attach to container and check ip of primary interface, usually this is `eth0`
    * `LOGIN`: Username used to login to machine hosting the docker container
    * `DOCKER_HOST`: Machine hosting the docker container

* Use RDP client to connect to `localhost:33389`
    * `user`: vargrant
    * `password`: vagrant
