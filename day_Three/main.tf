// Define AWS provider with US West 2 region
provider "aws" {
  region = "us-west-2"
}

//creating s3 bucket
resource "aws_s3_bucket" "<bucketNamehere>" {
  bucket = "<bucketNamehere>"
  acl    = "private"
// Define S3 bucket with private access control

  policy = <<EOF // Specifying the bucket policy in-line
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
    // Allowing any principal to perform the GetBucketAcl action on the specified resource
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
    // Allowing cloudtrail service to perform the PutObject action on all objects in the specified resource
    ]
}
EOF
}

resource "aws_cloudtrail" "<example>" {
  name = "<example>"

  s3_bucket_name = aws_s3_bucket.bucketnamehere.id
  // Specifying the name of the S3 bucket created earlier
  is_multi_region_trail = true
  // Enabling multi-region trail
}