FROM golang:1.17.8

COPY . /go/src/outyet
WORKDIR /go/src/outyet

ENV CGO_ENABLED=0
ENV GOOS=linux

RUN go get -v -d && \
    go install -v && \
    go test -v && \
    go build -ldflags "-s" -a -installsuffix cgo -o outyet .

EXPOSE 8080

CMD ["/go/src/outyet/outyet", "-version", "1.17.8", "-poll", "600s", "-http", ":8080"]

