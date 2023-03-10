100 Days of DevOps — Day 7(AWS S3 Event) Notifications
---

![S3 Event architecture](https://miro.medium.com/v2/resize:fit:828/format:webp/1*cg5pjr3WhjaeRnDQymQcnQ.png)

>Problem: Get a notification whenever an object in your S3 bucket is deleted.
***

>This can be achieved through:

- AWS Console
- Terraform

>Types of events for which you can get notified:
* [x] PUT
* [x] POST
* [x] COPY
* [x] Multipart upload completed
* [x] All object create events
* [x] Objects in RSS lost 

* [x] Permanently deleted
* [x] Delete marker created
* [x] All Object delete events
* [x] Restore from Glacier initiated
* [x] Restore from Glacier completed

***

Reference:

- [100 days of DevOps](https://devopslearning.medium.com/100-days-of-devops-day-7-aws-s3-event-cf64c6699ca1)
>>The link above has a Terraform script in the day_Seven but I was getting an EOF error, I therefore created my own script
