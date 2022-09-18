provider "aws" {
region = "us-east-2"
}
resource "aws_instance" "myawsserver" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "velmrnd-ec2-instance-key-pair"

  tags = {
    Name = "vel-DevOps-server"
    env = "Dev"
    owner = "vel"
  }
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} > /tmp/inv"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
