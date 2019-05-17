variable "region" {
  default = "us-west-2"
}

terraform {
  required_version = "~> 0.11"
}
provider "aws" {
  region = "${var.region}"
}

######################################################################
resource "aws_iam_role" "codaseed_iam_role" {
  name = "${var.netname}_codaseed_iam_role"
  assume_role_policy = <<EOF
{  "Version": "2012-10-17",
    "Statement": [
          { "Action": "sts:AssumeRole",
            "Principal": {"Service": "ec2.amazonaws.com"},
            "Effect": "Allow",
            "Sid": ""
          }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "coda" {
  name = "${var.netname}_coda"
  role = "${var.netname}_codaseed_iam_role"
}

resource "aws_iam_role" "dummy" {
  name = "${var.netname}_codaseed_iam_role_dummy"
  assume_role_policy = <<EOF
{  "Version": "2012-10-17",
    "Statement": [
          { "Action": "sts:AssumeRole",
            "Principal": {"Service": "ec2.amazonaws.com"},
            "Effect": "Allow",
            "Sid": ""
          }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "dummy" {
  name = "${var.netname}_dummy"
  role = "${var.netname}_codaseed_iam_role"

}

resource "aws_iam_policy" "codaseed_iam_policy" {
    name = "${var.netname}_codaseed_iam_policy"
    policy = <<EOF
{   "Version": "2012-10-17",
    "Statement": [
      { "Effect": "Allow",
        "Action": [
          "s3:ListBucket"
          ],
        "Resource": ["arn:aws:s3:::status.o1test.net"]
      },
      { "Effect": "Allow",
        "Action": [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
          ],
        "Resource": [
          "arn:aws:s3:::status.o1test.net/*",
          "arn:aws:s3:::o1labs-snarkette-data/*"
          ]
        }
      ]
    }
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = "${aws_iam_role.codaseed_iam_role.name}"
  policy_arn = "${aws_iam_policy.codaseed_iam_policy.arn}"
}