//Terraform script that creates a CloudWatch Log Metric Filter, Alarm, and SNS Topic to monitor for unauthorized access:
// on an ec2 instance
provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_log_metric_filter" "invalid_user" {
  name      = "invalid_user"
  pattern   = "\"invalid user\""
  log_group = aws_cloudwatch_log_group.log_group.name

  metric_transformation {
    name      = "invaliduser"
    namespace = "invaliduser"
    value      = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "ec2-instance-logs"
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_to_sns" {
  alarm_name          = "cloudwatch-to-sns"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "invaliduser"
  namespace           = "invaliduser"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "1"
  alarm_description   = "This metric alarm goes off when the invalid user count exceeds the specified threshold."
  alarm_actions       = [aws_sns_topic.Default_CloudWatch_Alarms_Topic.arn]
  alarm_state_reason  = "There is an invalid user: the specified threshold has been exceeded."
  alarm_state_value   = "ALARM"
  alarm_action_enabled = true
}

resource "aws_sns_topic" "Default_CloudWatch_Alarms_Topic" {
  name = "Default_CloudWatch_Alarms_Topic"

  display_name = "Default CloudWatch Alarms Topic"

  subscription {
    endpoint = "murimi101@gmail.com"
    protocol = "email"
  }
}

/* This script creates a CloudWatch Log Metric Filter that searches for the pattern "invalid user" 
in the ec2-instance-logs log group, creates a metric with the namespace invaliduser and metric name 
invaliduser whenever the filter matches, and assigns the value 1 to the metric.

It then creates a CloudWatch Metric Alarm that triggers when the invaliduser metric value is greater 
than or equal to 1 over a 60-second period. The alarm sends a message to an Amazon SNS topic when the 
alarm state is set to ALARM, and the SNS topic is subscribed to an email address specified by the endpoint parameter. 

NB: No need to provide the ec2 instance details because the alarm is monitoring the logs of an already running 
ec2 instance*/