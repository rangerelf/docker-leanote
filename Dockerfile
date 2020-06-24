FROM ubuntu:20.04 AS builder

ARG VERSION=2.6.1

RUN apt-get update -y \
 && apt-get install -y curl

RUN url="http://sourceforge.net/projects/leanote-bin/files/2.6.1/leanote-linux-amd64-v${VERSION}.bin.tar.gz/download" \
 && curl -Ls $url | tar xzf - -C /opt \
 && test -f /opt/leanote/bin/run.sh \
 && chown -R root:root /opt/leanote \
 && chmod 755 /opt/leanote/bin/run.sh \
 && mv /opt/leanote/conf/app.conf /opt/leanote/conf/app.conf.orig \
 && ln -svf /data/app.conf /opt/leanote/conf/app.conf

FROM ubuntu:20.04
VOLUME /data
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]

ENV MONGODB_ADDR=127.0.0.1

RUN apt-get update -y \
 && apt-get install -y mongodb-server mongodb-clients mongo-tools

COPY --from=builder /opt/leanote /opt/leanote
COPY ./entrypoint.sh /
