#! /bin/sh

cd /git/repo && git --bare init
chown git:git /git/repo -R
/etc/init.d/ssh restart
