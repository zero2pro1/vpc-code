# Resources Block
# Resource-1: Create VPC
resource "aws_vpc" "zero2pro-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "zero2pro-vpc"
  }
}

# Resource-2: Create Subnets
resource "aws_subnet" "zero2pro-vpc-public-subnet-1" {
  vpc_id                  = aws_vpc.zero2pro-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "zero2pro-vpc-igw" {
  vpc_id = aws_vpc.zero2pro-vpc.id
}

# Resource-4: Create Route Table
resource "aws_route_table" "zero2pro-vpc-public-route-table" {
  vpc_id = aws_vpc.zero2pro-vpc.id
}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "zero2pro-vpc-public-route" {
  route_table_id         = aws_route_table.zero2pro-vpc-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.zero2pro-vpc-igw.id
}

# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "zero2pro-vpc-public-route-table-associate" {
  route_table_id = aws_route_table.zero2pro-vpc-public-route-table.id
  subnet_id      = aws_subnet.zero2pro-vpc-public-subnet-1.id
}

# Resource-7: Create Security Group
resource "aws_security_group" "zero2pro-vpc-sg" {
  name        = "zero2pro-vpc-default-sg"
  description = "zero2pro VPC Default Security Group"
  vpc_id      = aws_vpc.zero2pro-vpc.id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}