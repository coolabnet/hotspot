FROM golang:latest

RUN apt update -y && apt install -y git apache2 jq

WORKDIR /go/src

# ssb
RUN git clone https://github.com/cryptoscope/ssb.git
RUN cd ssb/cmd/go-sbot && go build -v -i && cp go-sbot /usr/local/bin
RUN cd ssb/cmd/sbotcli && go build -v -i && cp sbotcli /usr/local/bin
RUN mkdir /root/.ssb-go
COPY ssb-config/* /root/.ssb-go/

# apache
RUN mkdir /var/run/apache2
COPY apache-config/* /etc/apache2/

COPY start.sh .
CMD ["bash", "start.sh"]
