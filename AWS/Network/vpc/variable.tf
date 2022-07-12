variable "vpc_cidr"{
 type = string
 description = "Enter a valid cidr_block x.x.x.x/x format"
 default = "10.0.0.0/16"
}

variable "vpc_name"{
 type = string
 description = "Enter VPC name"
}

variable "public_subnet_count"{
  type = string
}

variable "private_subnet_count"{
  type = string
}

variable "secured_subnet_count"{
  type = string
}

variable "public_subnet_size"{
  type = string
  default = 8
}

variable "private_subnet_size"{
  type = string
  default = 8
}

variable "secured_subnet_size"{
  type = string
  default = 8
}
