# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

data "aws_availability_zones" "available" {}

resource "aws_elb" "ashish_elb" {
  name = "ashish-elb"

  # The same availability zone as our instances
  availability_zones = ["${data.aws_availability_zones.available.names}"]

  access_logs {
    bucket        = "${aws_s3_bucket.ashish_elb_logs.bucket}"
    bucket_prefix = "elb-logs"
    interval      = 60
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "nginx_instance_profile"
  role = "${aws_iam_role.s3access-role.name}"
}

resource "aws_autoscaling_group" "ashish_asg" {
  availability_zones   = ["${data.aws_availability_zones.available.names}"]
  name                 = "ashish-example-asg"
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.ashish_lc.name}"
  load_balancers       = ["${aws_elb.ashish_elb.name}"]

  tag {
    key                 = "Name"
    value               = "ashish-asg"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "ashish_lc" {
  name                 = "ashish-asg-lc"
  image_id             = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.web_instance_profile.name}"
  security_groups      = ["${aws_security_group.ashish-test.id}"]
  user_data            = "${file("userdata.sh")}"
  key_name             = "${var.key_name}"
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "ashish-test" {
  name        = "ashish_sg"
  description = "Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.ssh_cidr_blocks}"
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
