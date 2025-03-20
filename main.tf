# Create a VPC
resource "aws_vpc" "VPCtest" {
  cidr_block = "10.0.0.0/16"
}