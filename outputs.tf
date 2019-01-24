output "id" {
  value = "${aws_efs_file_system.efs.id}"
}

output "dns" {
  value = "${aws_efs_file_system.efs.dns_name}"
}

output "sg_id" {
  value = "${aws_security_group.efs.id}"
}
