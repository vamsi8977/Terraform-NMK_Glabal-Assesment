resource "aws_instance" "linux_ec2" {
  count                  = "${var.ec2_instance_count}"
  ami                    = "ami-007855ac798b5175e"
  key_name               = "${var.key_name}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.linux_sg.id}"]
  subnet_id              = "${element(var.subnet_ids, count.index)}"
  tags = {
    Name = "${var.ec2_instance_name}"
  }
  provisioner "file" {
  source = "ec2_linux/numbers.py"
  destination = "/opt/numbers.py"
  }
  iam_instance_profile = "aws_iam_role.ec2_s3_access.name"
}
data "template_file" "user_data" {
  count    = "${var.ec2_instance_count}"
  template = "${file("${path.module}/templates/userdata.tpl")}"
}