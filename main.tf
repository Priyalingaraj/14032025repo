provider "aws" {
  region = "us-east-1"  # Specify your desired region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"  # Subnet CIDR block
  availability_zone       = "us-east-1a"    # Availability Zone
  map_public_ip_on_launch = true             # Automatically assign public IPs to instances
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-04aa00acb1165b32a"  # Use a valid AMI ID
  instance_type = "t2.micro"

  subnet_id = aws_subnet.main_subnet.id  # Specify the subnet where the instance will be launched

  tags = {
    Name = "MyEC2Instance"
  }
}
