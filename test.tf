provider "aws" {
  region = "<us-east-1>" #insert region
}
resource "aws_instance" "example_test" {
  ami           = "<ami-XXXXXXXXXXXXX>" #insert ami id
  instance_type = "t2.micro" #insert instance type

  tags = {
    Name = "<ExampleAppServerInstance>" #insert prefered tag name
  }
}