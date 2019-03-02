resource "aws_iam_role" "s3access-role" {
  name = "s3access-role"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy_document.json}"
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "s3access-policy" {
  name        = "s3access-policy"
  description = "A test policy"

  policy = "${data.aws_iam_policy_document.s3access.json}"
}

data "aws_iam_policy_document" "s3access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "attach-policy-to-role" {
  role       = "${aws_iam_role.s3access-role.name}"
  policy_arn = "${aws_iam_policy.s3access-policy.arn}"
}
