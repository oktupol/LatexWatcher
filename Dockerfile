FROM alpine:3.19.1

# Latex packages
RUN apk add texlive-full=20230506.66984-r3

# Dependencies for watcher script
RUN apk add inotify-tools=4.23.9.0-r0

RUN adduser -D watcher

# Watcher script
COPY watch.sh /home/watcher/watch.sh
RUN chmod +x /home/watcher/watch.sh

# Volumes
RUN mkdir -p /opt/watcher/cache
ENV CACHE_DIR="/opt/watcher/cache"

RUN mkdir -p /opt/watcher/source
ENV SOURCE_DIR="/opt/watcher/source"

RUN mkdir -p /opt/watcher/destination
ENV DESTINATION_DIR="/opt/watcher/destination"

VOLUME [ "/opt/watcher/cache", "/opt/watcher/source", "/opt/watcher/destination" ]

# Permissions
RUN chown -R watcher:watcher /home/watcher
RUN chown -R watcher:watcher /opt/watcher

USER watcher
WORKDIR /home/watcher

ENTRYPOINT [ "/home/watcher/watch.sh" ]
