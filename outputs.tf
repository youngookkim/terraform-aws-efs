output "id" {
  value = "${aws_efs_file_system.this.id}"
}

output "dns" {
  value = "${aws_efs_file_system.this.dns_name}"
}

output "sg_id" {
  value = "${aws_security_group.this.id}"
}
