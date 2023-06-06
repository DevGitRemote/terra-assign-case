
provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "a5-instance" {
  ami = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name = "keypair-1"
  user_data = "${file("install.sh")}"
  tags = {
  Name = "assignment5"
  }
}
output "IPv4" {
  value = "${aws_instance.a5-instance.public_ip}"
}
