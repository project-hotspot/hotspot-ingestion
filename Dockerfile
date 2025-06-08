FROM golang:1.23.2-bookworm AS builder

WORKDIR /workspace

# get dependencies
COPY go.mod go.sum ./
RUN go mod download

# get Proto dependencies
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
RUN apt update && apt install -y protobuf-compiler && rm -rf /var/lib/apt/lists/*

# build protos
COPY proto proto
RUN mkdir -p pkg/ingestion_proto
RUN protoc --proto_path ./proto \
    --go_out=./pkg/ingestion_proto \
    --go_opt=paths=source_relative \
    --go-grpc_out=./pkg/ingestion_proto \
    --go-grpc_opt=paths=source_relative \
    ./proto/ingestion.proto \
    ./proto/event.proto

# copy code and build
# disable CGO for portability to alpine
COPY main.go main.go
COPY pkg pkg
ENV CGO_ENABLED=0
RUN go build -o hotspot-ingestion

# run app
FROM alpine:3.22 AS runner
WORKDIR /app
COPY --from=builder /workspace/hotspot-ingestion .
EXPOSE 8080
CMD [ "./hotspot-ingestion" ]

