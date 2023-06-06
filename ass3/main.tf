provider "aws" {
        alias = "NV"
        region = "us-east-1"
        access_key = ""
        secret_key = ""
}
provider "aws" {
        alias = "Ohio"
        region = "us-east-2"
        access_key = ""
        secret_key = ""
}
resource "aws_instance" "assignment-3-1" {
        provider = aws.NV
        ami = ""
        instance_type = "t2.micro"
        key_name = ""
        tags = {
        Name = "hello-virginia"
        }
}
resource "aws_instance" "assignment-3-2" {
        provider = aws.Ohio
        ami = ""
        instance_type = "t2.micro"
        key_name = ""
        tags = {
        Name = "hello-ohio"
        }
}
