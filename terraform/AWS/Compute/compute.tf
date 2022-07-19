resource "aws_instance" "instance"{
  count = var.instancecount
  ami = var.amiid
  instance_type = var.instancetype
  key_name = "docker"
  subnet_id = var.subnetid[count.index % length(var.subnetid)]
  vpc_security_group_ids = tolist([var.securitygroup])

  tags = {
    Name = "${var.instancename}-${count.index}"
    Role = "${var.roletag}"
  }
}
