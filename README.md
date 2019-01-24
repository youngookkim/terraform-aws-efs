# AWS EFS

## Using module
You can use this module like as below example.

```
module "your_efs" {
  source  = "youngookkim/efs/aws"
  version = "1.0.0"

  name              = "exmple"
  stack             = "dev"
  detail            = "extra-desc"
  region            = "${var.aws_region}"
  vpc               = "${var.vpc_id}"
  subnets           = "${var.subnet_ids}"
  ingress_rules     = "${map("0", list(var.cidr, "2049", "2049", "tcp", "nfs"))}"
}
```
