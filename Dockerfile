##############################################################################
# Bootstrap Termux environment.
FROM scratch AS bootstrap

ARG SYSTEM_TYPE=mips

# Docker uses /bin/sh by default, but we don't have it currently.
SHELL ["/system/bin/sh", "-c"]
ENV PATH /system/bin

COPY /system /system

RUN \
	mkdir -p /home /data/tmp && \
	ln -s /data/tmp /tmp

##############################################################################
# Create final image.
FROM scratch

ENV ANDROID_DATA     /data
ENV ANDROID_ROOT     /system
ENV HOME             /home
ENV LANG             en_US.UTF-8
ENV PATH             /system/bin
ENV PREFIX           /system
ENV TMPDIR           /tmp
ENV TZ               UTC

COPY --from=bootstrap / /

WORKDIR /home
SHELL ["/system/bin/sh", "-c"]

CMD ["/system/bin/sh"]
