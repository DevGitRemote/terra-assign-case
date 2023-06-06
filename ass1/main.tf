provider "aws" {
  region = "us-east-1" #for N.Vriginia change to Ohio if you want
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "assignment-1" {
  ami = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name = "keypair-1"
  tags = {
    Name = "assignment-1"
    }
}
