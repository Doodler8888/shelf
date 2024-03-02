 provider "aws" {
   region = "your-preferred-region" # e.g., "us-east-1"
 }

resource "aws_s3_bucket" "my_book_bucket" {
  bucket = "your-unique-bucket-name" # Must be globally unique
}


resource "aws_iam_role" "bot_application_role" {
  name = "my-bot-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com" # Assuming your bot runs on EC2 
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "bot_s3_access" {
  role       = aws_iam_role.bot_application_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # Adjust if needed
}
