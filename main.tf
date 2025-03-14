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

resource "aws_s3_bucket" "my_bucket15032025" {
  bucket = "my-unique-bucket-name-12345"  # Make sure this bucket name is globally unique
  acl    = "private"  # You can choose other ACLs like "public-read" if needed

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Development"
  }
}


# Create a Route Table
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"  # Allows outbound traffic to the internet
    gateway_id = aws_internet_gateway.main_gateway.id
  }

  tags = {
    Name = "MainRouteTable"
  }
}
# Create an Internet Gateway
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main.id
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "main_association" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}