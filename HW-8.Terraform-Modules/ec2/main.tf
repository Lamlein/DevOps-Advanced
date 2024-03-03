# AWS Instances
resource "aws_instance" "public_instance" {
  ami           = "ami-0faab6bdbac9486fb" # Change AMI ID
  instance_type = var.public_instance_type
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "HD-Edu-Public-Instance-1"
  }
}
resource "aws_instance" "private_instance" {
  ami           = "ami-0faab6bdbac9486fb" # Change AMI ID
  instance_type = var.private_instance_type
  subnet_id     = var.private_subnet_id
  tags = {
    Name = "HD-Edu-Private-Instance-1"
  }
}
