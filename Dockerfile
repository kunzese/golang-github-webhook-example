FROM golang:1.13.5-alpine as builder
RUN apk add --no-cache git
WORKDIR /go/src/github.com/kunzese/golang-github-webhook-example
COPY . .
RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux go build -a -o /webhook main.go

FROM alpine:3.10.3
RUN apk add --no-cache ca-certificates
COPY --from=builder /webhook /webhook
CMD ["/webhook"]
