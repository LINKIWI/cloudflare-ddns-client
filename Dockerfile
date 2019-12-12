FROM ubuntu:18.04
RUN apt update && \
  apt -y dist-upgrade && \
  apt -y install \
  iproute2 \
  python3 \
  python3-pip
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
RUN python -m pip install \
  argparse \
  requests \
  tld
RUN groupadd -g 1001 cloudflare-ddns-client && \
  useradd -u 1001 -g 1001 -s /bin/bash -m cloudflare-ddns-client && \
  mkdir -p /usr/local/bin
USER cloudflare-ddns-client
COPY --chown=cloudflare-ddns-client cloudflare-ddns /usr/local/bin/cloudflare-ddns-client
CMD /usr/local/bin/cloudflare-ddns-client --update
