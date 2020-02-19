FROM alpine
ARG BINNAME
ARG PORT
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
ADD ./app/${BINNAME} /app/${BINNAME}
EXPOSE ${PORT}
ENTRYPOINT [/app/${BINNAME}]
