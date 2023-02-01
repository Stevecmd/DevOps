#Script that uses Cloudwatch logs(Metric filters)
#to create a simple monitoring system that alerts for any unauthorized access.

import boto3

# Initialize the boto3 client for CloudWatch Logs
cw_logs = boto3.client('logs')

# Define the log group and metric filter names
log_group_name = 'my-access-logs'
metric_filter_name = 'UnauthorizedAccess'

# Define the pattern for the metric filter
pattern = '{ ($.status = 401) || ($.status = 403) }'

# Create the log group
cw_logs.create_log_group(logGroupName=log_group_name)

# Create the metric filter
cw_logs.put_metric_filter(
    logGroupName=log_group_name,
    filterName=metric_filter_name,
    filterPattern=pattern,
    metricTransformations=[
        {
            'metricName': 'UnauthorizedAccessCount',
            'metricNamespace': 'MyApp',
            'metricValue': '1'
        },
    ]
)



#This script creates a CloudWatch Logs log group named my-access-logs and a metric filter named UnauthorizedAccess 
#that matches events with a status code of either 401 or 403 (unauthorized or forbidden access). The metric filter 
#increments a metric named UnauthorizedAccessCount in the MyApp namespace each time a matching event is recorded.

#You can then use CloudWatch Alarms to alert on the UnauthorizedAccessCount metric if the count exceeds a specified threshold over a specified time period.



#Creation of the cloudwatch alarm to be used

#Sample script in Python that creates a CloudWatch Alarm to alert when the UnauthorizedAccessCount metric exceeds a specified threshold over a specified time period:


import boto3

# Initialize the boto3 client for CloudWatch
cw = boto3.client('cloudwatch')

# Define the alarm name, metric namespace, and metric name
alarm_name = 'UnauthorizedAccessAlarm'
namespace = 'MyApp'
metric_name = 'UnauthorizedAccessCount'

# Define the alarm threshold and evaluation period
threshold = 1
evaluation_periods = 1

# Create the alarm
cw.put_metric_alarm(
    AlarmName=alarm_name,
    ComparisonOperator='GreaterThanOrEqualToThreshold',
    EvaluationPeriods=evaluation_periods,
    MetricName=metric_name,
    Namespace=namespace,
    Period=60,
    Statistic='Sum',
    Threshold=threshold,
    AlarmActions=[
        'arn:aws:sns:<REGION>:<ACCOUNT_ID>:<SNS_TOPIC>',
    ],
    AlarmDescription='This metric alarms when the unauthorized access count exceeds the specified threshold.',
    Unit='Count'
)




#This script creates a CloudWatch Alarm named UnauthorizedAccessAlarm that monitors the UnauthorizedAccessCount metric 
#in the MyApp namespace. The alarm triggers if the sum of the UnauthorizedAccessCount metric over a 60-second period 
#is greater than or equal to 1 (the specified threshold) for 1 evaluation period (1 minute). When the alarm is triggered, 
#it sends a message to an Amazon SNS topic specified by the AlarmActions parameter. Note that you will need to replace the <REGION>,
#<ACCOUNT_ID>, and <SNS_TOPIC> placeholders with the appropriate values for your account.