resource "aws_autoscaling_notification" "ashish_asg_scaling_notification" {
  group_names = [
    "${aws_autoscaling_group.ashish_asg.name}",
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = "${aws_sns_topic.ashish-asg-scaling-topic.arn}"
}

resource "aws_sns_topic" "ashish-asg-scaling-topic" {
  name = "ashish-asg-scaling-topic"

  # arn is an exported attribute
}
