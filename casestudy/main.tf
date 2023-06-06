provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "ec2" {
  ami = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name = "keypair-1"
  subnet_id = "${aws_subnet.psubnet.id}"
  user_data = <<-EOL
  #!/bin/bash -xe
  sudo apt update -y
  sudo apt install apache2 -y
  EOL
  tags = {
  Name = "casestudy-ec2"
  }
}
resource "aws_vpc" "vpcx" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "1"
  enable_dns_hostnames = "1"
  tags = {
  Name = "devraj"
  }
}
resource "aws_subnet" "psubnet" {
  vpc_id = "${aws_vpc.vpcx.id}"
  cidr_block = "10.0.32.0/19"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "1"
  tags = {
  Name = "public-subnet"
  }
}
resource "aws_default_security_group" "sg" {
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  vpc_id = "${aws_vpc.vpcx.id}"
  tags = {
  Name = "my-sg"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpcx.id}"
  tags = {
  Name = "my-igw"
  }
}
resource "aws_route" "internet" {
  route_table_id = "${aws_vpc.vpcx.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}
resource "aws_route_table_association" "a" {
  subnet_id = "${aws_subnet.psubnet.id}"
  route_table_id = "${aws_vpc.vpcx.default_route_table_id}"
}
resource "aws_network_interface" "face" {
  subnet_id = "${aws_subnet.psubnet.id}"
  tags = {
  Name = "mynetworkinterface"
  }
}
resource "aws_network_interface_attachment" "connection" {
  instance_id = "${aws_instance.ec2.id}"
  network_interface_id = "${aws_network_interface.face.id}"
  device_index = "1"
}
output "IPs" {
  value = "${aws_instance.ec2.public_ip}"
}
