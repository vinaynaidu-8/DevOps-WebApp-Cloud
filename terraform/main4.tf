# Create a Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 Instance
resource "aws_instance" "my_free_tier_ec2" {
  ami           = "ami-0088a4dc01f0b276f"  # Latest Ubuntu 22.04 in ap-south-1
  instance_type = "t2.micro"               # Free Tier eligible
  key_name      = "terraform-key"          # Must match your AWS key pair
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "FreeTier-EC2"
  }
}

# Output the public IP of the EC2 instance
output "ec2_public_ip" {
  value = aws_instance.my_free_tier_ec2.public_ip
}

