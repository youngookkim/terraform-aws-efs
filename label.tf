# label.tf

resource "random_string" "this" {
  length  = 4
  upper   = false
  lower   = true
  number  = false
  special = false
}

### frigga naming rule
locals {
  name = "${join("-", compact(list(var.name, var.stack, var.detail, local.slug, "efs")))}"
  slug = "${var.slug == "" ? random_string.this.result : var.slug}"
}
