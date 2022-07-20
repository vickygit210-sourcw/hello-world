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
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  }
}

output securitygrpid{
  value = aws_security_group.sg.id
}
