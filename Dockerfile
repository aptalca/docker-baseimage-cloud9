FROM lsiobase/cloud9:files-alpine as builder
FROM lsiobase/alpine:3.10

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# add files from c9base
COPY --from=builder /buildout/ /

RUN \
 echo "**** install base packages ****" && \
 apk add --no-cache \
	c-ares \
	curl \
	git \
	gnupg \
	http-parser \
	libevent \
	libevent \
	libstdc++ \
	libuv \
	sudo && \
 echo "****  user perms ****" && \
 usermod -aG wheel \
	abc

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8000
VOLUME /code
