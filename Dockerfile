FROM alpine:3
RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
  apk add --no-cache --update python3 && \
  apk add --update py-pip && \
  apk add iproute2 && \
  ln -s /usr/bin/python3 /usr/bin/python
RUN python3 -m pip install \
   argparse \
   tld
RUN addgroup -g 1001 cloudflare-ddns-client && \
  adduser -D -u 1001 -G cloudflare-ddns-client cloudflare-ddns-client && \
  mkdir -p /usr/local/bin
USER cloudflare-ddns-client
COPY --chown=cloudflare-ddns-client cloudflare-ddns /usr/local/bin/cloudflare-ddns-client
CMD /usr/local/bin/cloudflare-ddns-client --update
