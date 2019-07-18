ARG builder_image_version="1.11-alpine"
ARG runtime_image_version="3.9"

FROM golang:${builder_image_version} as builder
RUN apk add --no-cache git
WORKDIR /go/src/github.com/kunzese/golang-github-webhook-example
COPY . .
RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux go build -a -o /webhook main.go

FROM alpine:${runtime_image_version}
RUN apk add --no-cache ca-certificates
COPY --from=builder /webhook /webhook
CMD ["/webhook"]
