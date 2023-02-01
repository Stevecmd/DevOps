# Define the AWS provider with the region set to "us-west-2".
provider "aws" {
  region = "us-west-2"
}

# Create an AWS SNS topic.
resource "aws_sns_topic" "topic" {
  # Give the topic a name.
  name = "s3-event-notification-topic"

  # Define the policy for the topic.
  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": {"AWS":"*"},
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-event-notification-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.bucket.arn}"}
        }
    }]
}
POLICY
}

# Create an AWS S3 bucket.
resource "aws_s3_bucket" "bucket" {
  # Give the bucket a name.
  bucket = "s3-event-notification-topic-mydemo-bucket"
}

# Create a bucket notification for the S3 bucket.
resource "aws_s3_bucket_notification" "bucket_notification" {
  # Specify the S3 bucket to which the notification applies.
  bucket = "${aws_s3_bucket.bucket.id}"

  # Define the topic and events for the bucket notification.
  topic {
    topic_arn     = "${aws_sns_topic.topic.arn}"
    events        = ["s3:ObjectRemoved:*"]
  }
}
