FROM scratch

SHELL ["/system/bin/sh", "-c"]

ENV ANDROID_DATA=/data \
    ANDROID_ROOT=/system \
    HOME=/home \
    LANG=en_US.UTF-8 \
    PATH=/system/bin \
    PREFIX=/system \
    TMPDIR=/tmp \
    TZ=UTC

COPY /system /system

RUN mkdir -p /home /data/tmp && \
    ln -s /data/tmp /tmp

WORKDIR /home

CMD ["/system/bin/sh"]
