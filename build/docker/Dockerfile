FROM ubuntu
ARG BINNAME
ARG PORT=8080
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
ADD ./app/$BINNAME /app/$BINNAME
EXPOSE $PORT
ENTRYPOINT [ /app/$BINNAME ]