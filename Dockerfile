FROM golang:alpine AS builder

RUN apk update && apk add git && apk add ca-certificates

WORKDIR $GOPATH/src/github.com/williammartin/stockbroker
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /stockbroker .

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /stockbroker ./
