resource "aws_s3_bucket" "ashish_elb_logs" {
  bucket = "ashish-elb-logs"
  acl    = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "default" {
  bucket = "${aws_s3_bucket.ashish_elb_logs.id}"
  policy = "${data.aws_iam_policy_document.ashish_elb_logs.json}"
}

data "aws_iam_policy_document" "ashish_elb_logs" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.ashish_elb_logs.bucket}/*",
    ]

    principals = {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.elasticloadbalancing_account_ids["${var.aws_region}"]}:root"]
    }
  }
}
