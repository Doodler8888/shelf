package aws

import (
    "context"
    "bytes"
    // "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/s3"
)

func NewS3Client(ctx context.Context) (*s3.Client, error) {
    cfg, err := config.LoadDefaultConfig(ctx)
    if err != nil {
        return nil, err
    }

    return s3.NewFromConfig(cfg), nil
}

func UploadFileToS3(ctx context.Context, client *s3.Client, bucket, key string, file []byte) error {
    _, err := client.PutObject(ctx, &s3.PutObjectInput{
        Bucket: &bucket,
        Key:    &key,
        Body:   bytes.NewReader(file),
    })
    return err
}


