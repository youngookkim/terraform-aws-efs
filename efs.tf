# security/firewall
resource "aws_security_group" "efs" {
  name        = "${local.name}"
  description = "security group for ${local.name}"
  vpc_id      = "${var.vpc}"

  tags {
    Name = "${local.name}"
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  count             = "${length(var.ingress_rules)}"
  type              = "ingress"
  cidr_blocks       = ["${element(var.ingress_rules[count.index], 0)}"]
  from_port         = "${element(var.ingress_rules[count.index], 1)}"
  to_port           = "${element(var.ingress_rules[count.index], 2)}"
  protocol          = "${element(var.ingress_rules[count.index], 3)}"
  description       = "${element(var.ingress_rules[count.index], 4)}"
  security_group_id = "${aws_security_group.efs.id}"
}

resource "aws_security_group_rule" "egress_rules" {
  count             = "${length(var.egress_rules)}"
  type              = "egress"
  cidr_blocks       = ["${element(var.egress_rules[count.index], 0)}"]
  from_port         = "${element(var.egress_rules[count.index], 1)}"
  to_port           = "${element(var.egress_rules[count.index], 2)}"
  protocol          = "${element(var.egress_rules[count.index], 3)}"
  description       = "${element(var.egress_rules[count.index], 4)}"
  security_group_id = "${aws_security_group.efs.id}"
}

# efs instance

resource "aws_efs_file_system" "efs" {
  tags {
    Name = "${local.name}"
  }
}

resource "aws_efs_mount_target" "efs" {
  count           = "${length(split(",", var.subnets))}"
  file_system_id  = "${aws_efs_file_system.efs.id}"
  security_groups = ["${aws_security_group.efs.id}"]
  subnet_id       = "${element(split(",", var.subnets), count.index)}"
}
