Here's a general outline of the steps to create an internet-facing Classic Elastic Load Balancer 
with an Auto Scaling Group that provisions and configures Amazon Linux Apache web servers on t2.micro 
instances using the AWS CLI:

---

> 1. Configure AWS CLI:
aws configure

> 2. Create a Key Pair for EC2 instances:
aws ec2 create-key-pair --key-name my-key-pair --query 'KeyMaterial' --output text > my-key-pair.pem

> 3. Create a security group for the Load Balancer:
aws ec2 create-security-group --group-name my-load-balancer-sg --description "Security group for my load balancer"
aws ec2 authorize-security-group-ingress --group-name my-load-balancer-sg --protocol tcp --port 80 --cidr 0.0.0.0/0


> 4. Create a Launch Configuration that installs Apache:
'''aws autoscaling create-launch-configuration --launch-configuration-name my-launch-config --image-id ami-0c55b159cbfafe1f0 --instance-type t2.micro --key-name my-key-pair --security-groups my-load-balancer-sg --user-data "#!/bin/bash\n yum install -y httpd24\n service httpd start\n chkconfig httpd on\n echo '<html><body><h1>Hello World</h1></body></html>' > /var/www/html/index.html" '''


> 5. Create an Auto Scaling Group using the Launch Configuration:
aws autoscaling create-auto-scaling-group --auto-scaling-group-name my-auto-scaling-group --launch-configuration-name my-launch-config --min-size 1 --max-size 5 --desired-capacity 2 --vpc-zone-identifier <subnet-id>


> 6. Create a Classic Load Balancer:
aws elb create-load-balancer --load-balancer-name my-load-balancer --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --availability-zones <availability-zone> --security-groups my-load-balancer-sg


> 7. Register instances with the Load Balancer:
aws elb register-instances-with-load-balancer --load-balancer-name my-load-balancer --instances <instance-id>


> 8. Create a Classic Load Balancer policy:
aws elb create-lb-cookie-stickiness-policy --load-balancer-name my-load-balancer --policy-name my-cookie-policy --cookie-expiration-period 60


> 9. Apply the policy to the Load Balancer:
aws elb set-load-balancer-policies-of-listener --load-balancer-name my-load-balancer --load-balancer-port 80 --policy-names my-cookie-policy

---

>> **Bold/NB:** You can then verify that everything is working as expected by accessing the Load Balancer's DNS name using a web browser or by using the AWS CLI.