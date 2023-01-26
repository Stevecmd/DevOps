100 Days of DevOps -Day 4 (CloudWatch log agent Installation — Centos7)
---

Problem Statement
***
- Collect the System logs(/var/log/messages and /var/log/secure) and push it to CloudWatch Logs
- Collect custom metrics(Memory, Disk Space, Swap Utilization)

***

- **Bold/ This is the project implementation through Terraform.**
- **Bold/ The region chosen is us-east-1.**

- **Bold/ AWS CloudWatch** is an AWS service that is used to monitor, store, and access your log files from Amazon Elastic Compute Cloud (Amazon EC2) instances, AWS CloudTrail, Route 53, DNS Logs and other sources. You can then retrieve the associated log data from CloudWatch Logs.