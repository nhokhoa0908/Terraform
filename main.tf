terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = { 
    Name = "terraform-demo"
    env  = "dev"
  }
}

# Create a public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = { 
    Name = "public-subnet-1"
    env  = "dev"
  }
}

# Create a public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-1b"

  tags = { 
    Name = "public-subnet-2"
    env  = "dev"
  }
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-1c"

  tags = { 
    Name = "private-subnet"
    env  = "dev"
  }
}

# Create EC2 instances in public subnet 1
resource "aws_instance" "ec2_instance_public_1" {
  count         = 2
  ami           = "ami-02453f5468b897e31"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "ec2-instance-public-1-${count.index + 1}"
    env  = "dev"
  }
}

# Create EC2 instances in public subnet 2
resource "aws_instance" "ec2_instance_public_2" {
  count         = 2
  ami           = "ami-02453f5468b897e31"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "ec2-instance-public-2-${count.index + 1}"
    env  = "dev"
  }
}

output aws_vpc_id {
  value       = aws_vpc.example.id
  sensitive   = true
  description = "ID of the above VPC"
}
