resource "aws_s3_bucket" "s3-bucket" {
  bucket = "${var.s3_bucket_name}"
  policy = "${data.template_file.s3_bucket_policy.rendered}"
  force_destroy = "true"
  tags = {
    Name = "${var.s3_bucket_name}"
  }
}
data "template_file" "s3_bucket_policy" {
  template = "${file("${path.module}/templates/s3_policy.json.tpl")}"
  vars = {
    bucket = "vamsi-s3-aws-8977"
    all_userids = "${jsonencode(formatlist("%s:*",data.aws_iam_role.all_roles.*.unique_id))}"
  }
}
resource "aws_s3_bucket_policy" "policy" {
  bucket = "${var.s3_bucket_name}"
  policy = "${data.template_file.s3_bucket_policy.rendered}"
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = "${var.s3_bucket_name}"
  acl    = "private"
}
resource "aws_s3_bucket_server_side_encryption_configuration" "algorithm" {
  bucket = "${var.s3_bucket_name}"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}
data "aws_iam_role" "all_roles" {
  count = "${length(var.all_roles)}"
  name = "${var.all_roles}"
}
locals {
  role_unique_ids_formatted = "${formatlist("%s:*",data.aws_iam_role.all_roles.*.unique_id)}"
}