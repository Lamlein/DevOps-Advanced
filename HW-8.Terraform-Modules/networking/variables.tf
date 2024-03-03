# networking/variables.tf

variable "public_subnet_cidr" {
  # description = "CIDR block for the public subnet"
  # type        = string
  # default     = "10.0.1.0/24"
}

variable "vpc_cidr" {
  # description = "CIDR block for the aws_vpc"
  # type        = string
  # default     = "10.0.0.0/16"
}
variable "private_subnet_cidr" {
  # description = "CIDR block for the private subnet"
  # type        = string
  # default     = "10.0.101.0/24"
}


