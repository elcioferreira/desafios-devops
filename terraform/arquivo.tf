variable "var_region" {}
variable "var_ips" {}


provider "aws" {
  access_key = "AKIAJR3AB7YKMVZNXORA"
  secret_key = "yCkismFngslYOWDtP7vBnfNOOf7pMiciTAExxYM9"
  region     ="${var.var_region}"   
}
 
resource "aws_instance" "example" {
  ami           = "ami-09b9eaea4f33f0200"
  instance_type = "t2.micro"
  security_groups = [ "geral-sg" ]
}

 
resource "aws_security_group" "sg" {
  name = "geral-sg"
  description = "Allow all inbound traffic"
  vpc_id = "vpc-f5f3b592"
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${var.var_ips}"]  
  }
ingress {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"] 
  }
  ingress {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"] 
  }
  egress {
      from_port = 0 
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}


  output "instance_ips" {
  value = ["${aws_instance.example.public_ip}"] }
