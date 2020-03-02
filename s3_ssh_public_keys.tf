variable "ssh_public_key_names" {
  default = ["aws-key"]
  type    = list
}

resource "aws_s3_bucket" "ssh_public_keys" {
  region = var.region
  bucket = var.s3_bucket_name
  acl    = "private"

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Id": "Policy142469412148",
	"Statement": [
		{
			"Sid": "Stmt1425916919000",
			"Effect": "Allow",
			"Principal": {
				"AWS": "arn:aws:iam::282436823485:user/Administrator"
			},
			"Action": [
				"s3:List*",
				"s3:Get*"
			],
			"Resource": "arn:aws:s3:::${var.s3_bucket_name}"
		}
	]
}
EOF
}

resource "aws_s3_bucket_object" "ssh_public_keys" {
  bucket = aws_s3_bucket.ssh_public_keys.bucket
  key    = "${element(var.ssh_public_key_names, count.index)}.pub"

  source = "public_keys/${element(var.ssh_public_key_names, count.index)}.pub"
  count  = length(var.ssh_public_key_names)

  depends_on = [aws_s3_bucket.ssh_public_keys]
}