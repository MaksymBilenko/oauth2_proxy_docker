FROM golang:1.10-alpine as builder

RUN apk update && apk add git

RUN go get github.com/bitly/oauth2_proxy

FROM alpine:latest

COPY --from=builder /go/bin/oauth2_proxy /oauth2_proxy

RUN apk update && apk add ca-certificates

ENTRYPOINT ["/oauth2_proxy"]
