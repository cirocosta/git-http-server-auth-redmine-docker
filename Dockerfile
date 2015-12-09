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
RUN apt-get -qq -y apache2

## Install grack
WORKDIR /srv
RUN mkdir /git/repo
chown -R apache:apache /git/repo

## Remove /etc/motd
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic 
RUN ln -fs /dev/null /run/motd.dynamic

## Clean up
WORKDIR /
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /git/repo

ADD gitstart.sh  /etc/my_init.d/01_gitstart.sh
