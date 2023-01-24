provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "example_test" {
  ami           =  "ami-XXXXXXXXXXXXX" 
  instance_type = "t2.micro"
}