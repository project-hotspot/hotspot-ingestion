# Hotspot Ingestion

This repository contains the ingestion service for the hotspot project. The ingestion service is a gRPC server that receives events from the hotspot project and, after validating them, sends them to the Kafka broker.

## Getting Started

To get started developing locally, make sure you have the protobuf compiler installed. Make sure you also have
protoc-gen-go and protoc-gen-go-grpc installed. Then, you can compile the protos using the following command
from the root of the repository:

```sh
mkdir -p pkg/ingestion_proto
protoc --proto_path ./proto --go_out=./pkg/ingestion_proto --go_opt=paths=source_relative --go-grpc_out=./pkg/ingestion_proto --go-grpc_opt=paths=source_relative ./proto/ingestion.proto ./proto/event.proto
```

Then, you can run the server using the following command:

```sh
go run ingestion
```
