FROM alpine:3.9.5

RUN apk update && \
    apk add nmap curl bash

RUN curl -LO https://github.com/ldn-softdev/jtm/raw/master/jtm-linux-64.v2.09
RUN chmod +x ./jtm-linux-64.v2.09

COPY ./run-nmap-jtm.sh run-nmap-jtm.sh

ENTRYPOINT ["bash", "./run-nmap-jtm.sh"]
