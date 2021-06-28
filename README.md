# aptly-container
Files needed to build Aptly in a container with REST API support and running with nginx
  
The Aptly project (https://www.aptly.info) is a swiss army knife for
Debian repository management: it allows you to mirror remote
repositories, manage local package repositories, take snapshots, pull
new versions of packages along with dependencies, publish as Debian
repository. You can try it right now for free.
  
**NOTE** The Aptly project has been undergoing some development
  hickups as the maintainer no longer has time to maintain the
  project. A group of developers are in the process of reviving the
  project and it is hoped that it can continue and expand its feature
  set ([reference](https://github.com/aptly-dev/aptly/issues/920)).

**NOTE** This project makes use of a fork of Aptly found by the folks
  that work on the [Molior Debian build
  system](https://github.com/molior-dbs/aptly). The fork is used since
  the REST API in the main Aptly project is incomplete and does not
  support mirroring ([reference](https://www.aptly.info/doc/api/)).

## Dockerhub
To facilitate the use of Aptly this project aims to wrap Aptly in a
Docker container and exposes the repository contents using nginx and
the REST API via Aptly 'serve'. You can easily use this project to
rebuild and customize the container, or you can pull a pre-built
container from Dockerhub at
https://hub.docker.com/repository/docker/markawr/aptly.

### Dockerhub Usage
Run the following to get up and running with the pre-build image from Docerkhub
```
docker run \
  --detach=true \
  --restart=always \
  --name="aptly" \
  --env HOSTNAME=$(hostname) \
  --volume /tmp/aptly:/var/aptly \
  --publish 80:80 \
  --publish 8080:8080 \
  markawr/aptly:latest
```

The default *nginx.conf* and *aptly.conf* will be written to the
shared volume. If you wish to edit either configuration shutdown the
container, edit the configuration file and restart the container. As
well as configuration files all Aptly persistent data will be stored
in the shared volume. At this time GPG is not supported by the default
container.

## REST API Client library
As previously stated Aptly does not have a complete REST API and thus
mirror functionality is not available. Since we build a fork of Aptly
which has this functionality available you have several choices to
make use of this new functionality. You can use a REST API Library
such as that available from
[gopythongo](https://github.com/gopythongo/aptly-api-client/) and
access the mirror API indirectly, or you can use a fork of the
aptly-api-client which includes additional functionality to support
this.

## Building
In order to build the Aptly container clone this repository and run
```
./build.sh
```
