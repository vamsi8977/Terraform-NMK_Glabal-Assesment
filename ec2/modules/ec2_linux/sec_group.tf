## Security Groups
resource "aws_security_group" "linux_sg" {
  name        = "${var.ec2_instance_name}-linux-sg"
  vpc_id      = "${var.vpc_id}"
}
resource "aws_security_group_rule" "local_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["150.221.160.23/32"]
  security_group_id = "${aws_security_group.linux_sg.id}"
  description       = "Allow connection from local"
}
