provider "aws" {
  region = "us-east-1"
}

//creating s3 bucket
resource "aws_s3_bucket" "<bucketNamehere>" {
  bucket = "<bucketNamehere>"
  acl    = "private"

  policy = <<EOF

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::<bucketnamehere>"
        },
        {
            "Sid": "CloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::<bucketnamehere>/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
EOF
}

resource "aws_cloudtrail" "example" {
  name = "example"

  s3_bucket_name = aws_s3_bucket.bucketnamehere.id
  is_multi_region_trail = true
}