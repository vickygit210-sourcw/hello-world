variable sgname{
  type = string
  description = "Security Group Name"
  default = "testsg"
}

variable sgdescription{
  type = string
  description = "Description of the security group"
  default = "test"
}

variable vpcid{
  type = string
  description = "VPC ID of the attached VPC"
  default = "vpc-61c5b81b"
}

variable ingressrules{
  type = list(object({
    port = number
    description = string
    cidrblock = list(string)
    protocol = string
    }))
  description = "Security group rule as list of object"
  default = [{
    port = 443
    description = "https"
    cidrblock = ["0.0.0.0/0"]
    protocol = "tcp"
  },
  {
    port = 80
    description = "http"
    cidrblock = ["0.0.0.0/0"]
    protocol = "tcp"
  },
  {
    port = 22
    description = "ssh"
    cidrblock = ["0.0.0.0/0"]
    protocol = "tcp"
  }
  ]

}
