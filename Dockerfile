# Primeiro estágio: Construa o aplicativo usando TinyGo
FROM tinygo/tinygo:0.29.0 AS builder

WORKDIR /workspace

# Copie os arquivos de código-fonte para o diretório de trabalho
COPY golang/ .

ENV GOOS=linux
ENV GOARCH=386

# Compile o aplicativo usando o TinyGo e gera o binário no diretório de trabalho
RUN tinygo build -o /tmp/full
#build -ldflags=-compressdwarf=false

# Segundo estágio: Crie a imagem final
FROM rancher/busybox:1.31.1

WORKDIR /app

# Copie o binário do aplicativo TinyGo do primeiro estágio
COPY --from=builder /tmp/full .

# Defina o comando de execução
CMD ["./full"]
