package aws

import (
    "context"
    "bytes"
    "time"
    "github.com/aws/aws-sdk-go-v2/aws"
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

func GetPresignURL(cfg aws.Config, bucketName, keyName string) (string, error) {
    s3Client := s3.NewFromConfig(cfg)
    presignClient := s3.NewPresignClient(s3Client)
    presignedURL, err := presignClient.PresignGetObject(context.Background(),
        &s3.GetObjectInput{
            Bucket: aws.String(bucketName),
            Key:    aws.String(keyName),
        },
        s3.WithPresignExpires(15*time.Minute),
    )
    if err != nil {
        return "", err
    }
    return presignedURL.URL, nil
}

func PutPresignURL(cfg aws.Config, bucketName, objectName string) (string, error) {
    s3Client := s3.NewFromConfig(cfg)
    presignClient := s3.NewPresignClient(s3Client)
    presignedURL, err := presignClient.PresignPutObject(context.Background(),
        &s3.PutObjectInput{
            Bucket: aws.String(bucketName),
            Key:    aws.String(objectName),
        },
        s3.WithPresignExpires(15*time.Minute),
    )
    if err != nil {
        return "", err
    }
    return presignedURL.URL, nil
}

