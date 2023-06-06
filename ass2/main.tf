provider "aws" {
        region = "us-east-1"
        access_key = ""
        secret_key = ""
}
resource "aws_instance" "assignment-2" {
        ami = "ami-007855ac798b5175e"
        instance_type = "t2.micro"
        key_name = "keypair-1"
        tags = {
        Name = "assignment-2"
        }
}
resource "aws_eip" "eip" {
  vpc = true
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.assignment-2.id}"
  allocation_id = "${aws_eip.eip.id}"
}
