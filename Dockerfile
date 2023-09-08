FROM tinygo/tinygo:0.29.0 AS builder

WORKDIR /workspace

COPY golang/ .

ENV GOOS=linux
ENV GOARCH=386

RUN tinygo build -o /tmp/full

FROM scratch

WORKDIR /app

COPY --from=builder /tmp/full /app/full

CMD ["./full"]
