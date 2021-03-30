FROM alpine:3.10
MAINTAINER santisi.io <juan@santisi.io>

ENV LANG C.UTF-8
# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u252
ENV JAVA_ALPINE_VERSION 8.252.09-r0

RUN set -x \
	&& apk add --no-cache \
    bash \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

RUN apk update
RUN apk add gradle \
            bash
RUN mkdir -p /usr/app
WORKDIR /usr/app
#ADD /Users/jsantisi/dev/gitlab/sfdc-selenium-test /usr/app
#ADD /Users/jsantisi/dev/gitlab/sfdc-selenium-test /usr/app
