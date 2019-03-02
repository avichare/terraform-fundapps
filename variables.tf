variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

# ubuntu-public-image
variable "aws_amis" {
  default = {
    "eu-west-1" = "ami-08b24c07d4426e14d"
  }
}

variable "ssh_cidr_blocks" {
  default     = ["0.0.0.0/0"]
  description = "It is not recommended to use this default value for Production env"
}

variable "key_name" {
  default     = "ashish-key"
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}

variable  "elasticloadbalancing_account_ids" {
  default {
    eu-west-1 = "156460612806"
  }
}
