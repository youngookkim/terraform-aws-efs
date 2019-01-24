# security group for efs access
resource "aws_security_group" "this" {
  name        = "${local.name}-efs"
  description = "${local.name} EFS SG"
  vpc_id      = "${var.vpc}"

  tags {
    Name = "${local.name}-efs"
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
  security_group_id = "${aws_security_group.this.id}"
}

resource "aws_security_group_rule" "egress_rules" {
  count             = "${length(var.egress_rules)}"
  type              = "egress"
  cidr_blocks       = ["${element(var.egress_rules[count.index], 0)}"]
  from_port         = "${element(var.egress_rules[count.index], 1)}"
  to_port           = "${element(var.egress_rules[count.index], 2)}"
  protocol          = "${element(var.egress_rules[count.index], 3)}"
  description       = "${element(var.egress_rules[count.index], 4)}"
  security_group_id = "${aws_security_group.this.id}"
}

# efs instance

resource "aws_efs_file_system" "this" {
  tags {
    Name = "${local.name}"
  }
}

resource "aws_efs_mount_target" "this" {
  count           = "${length(split(",", var.subnets))}"
  file_system_id  = "${aws_efs_file_system.this.id}"
  security_groups = ["${aws_security_group.this.id}"]
  subnet_id       = "${element(split(",", var.subnets), count.index)}"
}
