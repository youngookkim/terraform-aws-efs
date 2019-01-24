# variables.tf

### network
variable "region" {
  description = "The aws region to deploy the service into"
  default     = "us-east-1"
}

variable "azs" {
  description = "A list of availability zones for the vpc"
  type        = "list"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc" {
  description = "The AWS ID of the VPC this shard is being deployed into"
}

variable "subnets" {
  description = "A list of subnets to locate efs"
}

### security

# inbound
# cidr,   from_port,  to_port, protocol, description
variable "ingress_rules" {
  description = "ingress list for security group allows"
  type        = "map"
  default     = {}
}

# outbound
# cidr,   from_port,  to_port, protocol, description
variable "egress_rules" {
  description = "egress list for security group allows"
  type        = "map"

  default = {
    "0" = ["0.0.0.0/0", "443", "443", "tcp", "https"]
    "1" = ["0.0.0.0/0", "80", "80", "tcp", "http"]
    "2" = ["0.0.0.0/0", "123", "123", "udp", "time sync"]
  }
}

### description
variable "name" {
  description = "The logical name of the module instance"
  default     = "default"
}

variable "stack" {
  description = "Text used to identify stack or environment"
  default     = "default"
}

variable "detail" {
  description = "The extra description of module instance"
  default     = ""
}

variable "slug" {
  description = "A random string to be end of tail of module name"
  default     = ""
}
