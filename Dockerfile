FROM debian:stable
MAINTAINER Michael Stapelberg <michael+nas@stapelberg.ch>

# Install perl for Data::Dumper
RUN apt-get update \
    && apt-get install -y rsync ssh perl

ADD sync.pl /usr/bin/

ENTRYPOINT ["/usr/bin/sync.pl"]
