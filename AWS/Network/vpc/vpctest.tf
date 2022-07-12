data "aws_availability_zones" "available"{}

resource "aws_vpc" "main"{
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
    Createdby = "terraform"
  }
}

resource "aws_subnet" "public" {
    count = var.public_subnet_count
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr,var.public_subnet_size,count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
      Name = "Pubsubnet-${count.index + 0}"
      Tier = "Public"
    }
}

resource "aws_subnet" "private" {
    count = var.private_subnet_count
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr,var.private_subnet_size,"${count.index + var.public_subnet_count}")
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
      Name = "Privsubnet-${count.index + 0}"
      Tier = "Private"
    }
    depends_on = [aws_subnet.public]
}

resource "aws_subnet" "secured" {
    count = var.secured_subnet_count
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr,var.secured_subnet_size,"${count.index + var.public_subnet_count + var.private_subnet_count}")
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
      Name = "Secsubnet-${count.index + 0}"
      Tier = "Secured"
    }
    depends_on = [aws_subnet.private]
}

output "vpc_id"{
  value = "${aws_vpc.main.id}"
}

output "pubsubnetids"{
  value = tolist(aws_subnet.public.*.id)
}

output "prvsubnetids"{
  value = tolist(aws_subnet.private.*.id)
}

output "secsubnetids"{
  value = tolist(aws_subnet.secured.*.id)
}
