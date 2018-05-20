FROM golang:1.10-alpine as builder

RUN apk update && apk add git

RUN go get -d github.com/bitly/oauth2_proxy
RUN cd /go/src/github.com/bitly/oauth2_proxy && git fetch origin pull/534/head:pr534 && git checkout pr534 && go install

FROM alpine:latest

COPY --from=builder /go/bin/oauth2_proxy /oauth2_proxy

RUN apk update && apk add ca-certificates

ENTRYPOINT ["/oauth2_proxy"]
