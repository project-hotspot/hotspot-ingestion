package ingestion_service

import (
	"context"
	"fmt"
	"ingestion/pkg/ingestion_proto"

	"github.com/golang/protobuf/ptypes/empty"
)

// TODO - this should hold Kafka producer
type IngestionService struct {
	ingestion_proto.UnimplementedIngestionServer
}

func NewIngestionService() *IngestionService {
	return &IngestionService{}
}

func (ingestionService *IngestionService) IngestEvent(_ context.Context, event *ingestion_proto.LocationEvent) (*empty.Empty, error) {
	fmt.Println("Ingesting event: ", event)
	return &empty.Empty{}, nil // TODO - do stuff here
}
