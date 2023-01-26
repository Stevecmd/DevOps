provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "cloudwatchlogs-to-earn" {
  name = "cloudwatchlogs-to-earn"
  description = "Allows EC2 instances to call AWS services on your behalf"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "CloudWatchAgentServerPolicy" {
  name       = "CloudWatchAgentServerPolicy"
  roles      = [aws_iam_role.cloudwatchlogs-to-earn.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_policy_attachment" "AmazonSSMFullAccess" {
  name       = "AmazonSSMFullAccess"
  roles      = [aws_iam_role.cloudwatchlogs-to-earn.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_instance" "example" {
  ami           = "<insert ami ID here>"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_role.cloudwatchlogs-to-earn.name
  // install cloudwatch agent
  user_data     = <<-EOF
#!/bin/bash
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
  EOF
}
resource "aws_instance" "cloudwatch_agent" {
  ami           = var.ami
  instance_type = var.instance_type

  user_data = <<-EOF
    #!/bin/bash
    # Install the CloudWatch Agent
    wget -O /tmp/amazon-cloudwatch-agent.deb https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
    sudo dpkg -i /tmp/amazon-cloudwatch-agent.deb
    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/tmp/cloudwatch-config.json -s
  EOF
}