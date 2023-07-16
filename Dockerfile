FROM debian:stable

LABEL "name"="Debian Package Builder"
LABEL "description"="GitHub Action for build Debian source package."
LABEL "maintainer"="iHub TO <mail@ihub.to>"
LABEL "repository"="https://github.com/ghastore/build-debian.git"
LABEL "homepage"="https://github.com/ghastore"

RUN apt update && apt install --yes ca-certificates

COPY sources-list /etc/apt/sources.list
COPY *.sh /
RUN apt update && apt install --yes bash curl git git-lfs rhash tar xz-utils build-essential fakeroot devscripts

ENTRYPOINT ["/entrypoint.sh"]
