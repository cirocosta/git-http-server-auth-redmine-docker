git-http-server-auth-redmine-docker
=================

A minimal GIT server with a redmine authentication
integration


Build instructions:
===================

git clone https://github.com/nttdata-osscloud/git-http-server-auth-redmine-docker

docker build -t 'nttdataosscloud/git-http-server' .

Usage instructions:
===================

To run this first create a data directory on your docker host to hold git data.

Run the container.

docker run -d -p 2222:22 -v /repo:/git/repo nttdataosscloud/git-http-server

You may substitute '2222' with any port number of your choosing.
You may substitute '/rep' with any place git data hold.

Clone the repo from a client:

git clone http://user:pass@myserver:2222/git/repo


