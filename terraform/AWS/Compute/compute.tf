resource "aws_instance" "instance"{
  count = var.instancecount
  ami = var.amiid
  instance_type = var.instancetype
  subnet_id = var.subnetid[count.index % length(var.subnetid)]
  vpc_security_group_ids = tolist([var.securitygroup])
  instance_state = running

  tags = {
    Name = "${var.instancename}-${count.index}"
    Role = "${var.roletag}"
  }
}
