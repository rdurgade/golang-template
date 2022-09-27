FROM alpine
ARG BINNAME
ARG PORT=8080
ENV STARTUP=/app/${BINNAME}
RUN apk update && apk add ca-certificates libc6-compat && rm -rf /var/cache/apk/*
ADD ./app/${BINNAME} /app/${BINNAME}
EXPOSE ${PORT}
ENTRYPOINT $STARTUP
