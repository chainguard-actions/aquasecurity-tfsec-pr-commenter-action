FROM public.ecr.aws/docker/library/alpine:3.12@sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69

RUN apk --no-cache --update add bash git \
    jq curl \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
