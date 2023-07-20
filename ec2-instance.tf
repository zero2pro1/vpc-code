# Resource-8: Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-047a51fa27710816e" # Amazon Linux
  instance_type          = "t2.micro"
  key_name               = "zero2pro-tf-key"
  subnet_id              = aws_subnet.zero2pro-vpc-public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.zero2pro-vpc-sg.id]
  #user_data = file("user-data.sh")
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to Zero2pro ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
    EOF
  tags = {
    "Name" = "zero2proec2vm"
  }
}