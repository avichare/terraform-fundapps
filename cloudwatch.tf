resource "aws_cloudwatch_metric_alarm" "ashish_elb_unhealthy_host" {
  alarm_name          = "ashish-elb-unhealthy-host"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ELB"
  period              = "120"
  statistic           = "Average"
  threshold           = "0"

  dimensions = {
    LoadBalancerName = "${aws_elb.ashish_elb.id}"
  }

  alarm_description = "This metric monitors elb unhealthy host count"
}
