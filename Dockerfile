FROM golang:latest

ENV APP_NAME app
ENV PORT 8080

WORKDIR /go/src/${APP_NAME}

COPY . /go/src/${APP_NAME}

RUN CGO_ENABLED=0 go build -o ${APP_NAME}

FROM scratch

ENV PORT 8080

WORKDIR /app

COPY --from=builder /go/src/${APP_NAME}/${APP_NAME} .

EXPOSE ${PORT}

CMD ["./app"]
