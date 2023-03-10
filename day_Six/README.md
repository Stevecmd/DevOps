100 Days of DevOps — Day 6-CloudWatch Logs(Metric Filters)
---

>Problem: I want to deploy a simple monitoring system where when any unauthorized entity tries to access my servers, I will get notified via SNS.
***

- Solution: This can be achieved using CloudWatch Metric Filter in combination with SNS.
- [Medium Tutorial](https://miro.medium.com/v2/resize:fit:828/format:webp/1*0OzqYNGqzR0wtHXdovwg0g.jpeg)
***

Reference:

- [100 days of DevOps](https://devopslearning.medium.com/100-days-of-devops-day-6-cloudwatch-logs-metric-filters-94c572cc241)

- [Youtube tutorial](https://www.youtube.com/watch?v=QgfMCDkVRPA)

***
NB: 
- The Python script may need a touch up, I also didnt specify the email address because it will get it from the sns topic which should be created before-hand.
- I specified the sns details in the Terraform script assuming that the sns topic had not been previously created.

