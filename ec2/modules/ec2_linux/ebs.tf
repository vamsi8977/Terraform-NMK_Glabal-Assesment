## EBS Volume
resource "aws_ebs_volume" "data_ebs" {
  count             = "${var.ec2_instance_count}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  size              = "10"
  type              = "gp2"
  encrypted         = "true"
  kms_key_id        = "arn:aws:kms:us-east-1:987184634634:key/9133941e-8b0b-47b0-8430-f84bcbd48dde"
}
resource "aws_volume_attachment" "attach_data_ebs" {
  count       = "${var.ec2_instance_count}"
  device_name = "/dev/sdf"
  volume_id   = "${element(aws_ebs_volume.data_ebs.*.id, count.index)}"
  instance_id = "${element(aws_instance.linux_ec2.*.id, count.index)}"
}