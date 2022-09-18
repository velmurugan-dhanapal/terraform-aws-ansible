provider "aws" {
region = "us-east-2"
}
resource "aws_instance" "myawsserver" {
  ami = "ami-0568773882d492fc8"
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
