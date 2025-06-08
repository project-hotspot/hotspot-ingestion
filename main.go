package main

import (
	"ingestion/pkg/ingestion_proto"
	"ingestion/pkg/ingestion_service"
	"net"

	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	server := grpc.NewServer()
	ingestion_proto.RegisterIngestionServer(server, ingestion_service.NewIngestionService())
	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		panic(err)
	}
	reflection.Register(server)
	server.Serve(listener)
}
