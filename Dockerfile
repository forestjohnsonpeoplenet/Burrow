FROM golang:alpine

MAINTAINER LinkedIn Burrow "https://github.com/linkedin/Burrow"

RUN apk add --no-cache curl bash git ca-certificates wget \
 && update-ca-certificates \
 && curl -sSO https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm \
 && chmod +x gpm \
 && mv gpm /usr/local/bin

ADD Godeps $GOPATH/src/github.com/linkedin/Burrow/
RUN cd $GOPATH/src/github.com/linkedin/Burrow && gpm install

ADD . $GOPATH/src/github.com/linkedin/Burrow
<<<<<<< HEAD
RUN cd $GOPATH/src/github.com/linkedin/Burrow && go install && mv $GOPATH/bin/Burrow $GOPATH/bin/burrow
=======
RUN cd $GOPATH/src/github.com/linkedin/Burrow \
 && gpm install \
 && go install \
 && mv $GOPATH/bin/Burrow $GOPATH/bin/burrow \
 && apk del git curl wget
>>>>>>> refs/remotes/upstream/master

ADD docker-config /etc/burrow

RUN ls /etc/burrow

WORKDIR /var/tmp/burrow

ADD burrow_runtime.sh /
RUN chmod +x /burrow_runtime.sh && sed -ri 's/\r//' /burrow_runtime.sh 

CMD ["/bin/sh", "/burrow_runtime.sh"]
