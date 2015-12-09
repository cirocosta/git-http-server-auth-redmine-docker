## Standard phusion part
FROM phusion/baseimage:latest
ENV HOME /root
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh    # Uncomment to Disable SSHD
CMD ["/sbin/my_init"]

## Expose ports.
EXPOSE 80
## Application specific part
MAINTAINER Hiroshi Miura <miurahr@nttdata.co.jp>
WORKDIR /tmp
RUN apt-get -qq -y update && apt-get -qq -y upgrade
RUN apt-get -qq -y --force-yes install git-sh git sharutils

## Setup service
# Setup a git user and SSH
RUN groupadd -g 987 git && useradd -g git -u 987 -d /git -m -r -s /usr/bin/git-shell git
#Set a long random password to unlock the git user account
RUN usermod -p `dd if=/dev/urandom bs=1 count=30 | uuencode -m - | head -2 | tail -1` git

## Remove /etc/motd
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic 
RUN ln -fs /dev/null /run/motd.dynamic

## Clean up
WORKDIR /
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /git/repo

ADD gitstart.sh  /etc/my_init.d/01_gitstart.sh