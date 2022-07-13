resource aws_security_group sg{
  name = var.sgname
  description = var.sgdescription
  vpc_id = var.vpcid

  dynamic "ingress" {
    for_each = var.ingressrules

    content {
      description = ingress.value.description
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidrblock
    }

  }
}

output securitygrpid{
  value = aws_security_group.sg.id
}
