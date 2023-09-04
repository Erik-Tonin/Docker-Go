
FROM golang:latest as builder

WORKDIR /go/src/app

COPY . .

RUN CGO_ENABLED=0 go build -o app && chmod +x app

FROM scratch

WORKDIR /app

COPY --from=builder /go/src/app/app .

EXPOSE 8080

CMD ["./app"]