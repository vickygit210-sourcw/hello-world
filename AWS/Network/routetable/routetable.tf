#Public Route
resource "aws_route_table" "pubrt"{
  vpc_id = var.vpcid
  tags = {
    Name = "publicrt"
    }
}

#Private Route
resource "aws_route_table" "prvrt"{
  count = length(var.prvsubnetid)
  vpc_id = var.vpcid
  tags = {
    Name = "privatert"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "igw"{
  vpc_id = var.vpcid
  tags = {
    Name = "internetgwy"
   }
  depends_on = [aws_route_table.pubrt]
}

#Egress Only Gateway
#resource "aws_egress_only_internet_gateway" "egw"{
#  vpc_id = var.vpcid
#  tags = {
#    Name = "egressgwy"
#    }
#  depends_on = [aws_route_table.prvrt]
#}

#NAT gateway

## Elastic IP for NAT gateway
resource "aws_eip" "eip"{
  count = length(var.prvsubnetid) <= 0 ? 0:length(var.pubsubnetid)
  vpc = true
}

resource "aws_nat_gateway" "ngw"{
  count = length(var.prvsubnetid) <= 0 ? 0:length(var.pubsubnetid)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id = var.pubsubnetid[0]
}

#Public Route
resource "aws_route" "pubr"{
  route_table_id = aws_route_table.pubrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id

  depends_on = [aws_internet_gateway.igw]
}

#Private Route
resource "aws_route" "prvr"{
  count = length(var.prvsubnetid)
  route_table_id = aws_route_table.prvrt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.ngw[count.index].id

}

#Public Subnet Association
resource "aws_route_table_association" "pubrtassociation"{
  count = length(var.pubsubnetid)
  route_table_id = aws_route_table.pubrt.id
  subnet_id = var.pubsubnetid[count.index]
}

#Private Subnet Association
resource "aws_route_table_association" "prvrtassociation"{
  count = length(var.prvsubnetid)
  route_table_id = aws_route_table.prvrt[count.index].id
  subnet_id = var.prvsubnetid[count.index]
}

output "pubrt_table_id"{
  value = "${aws_route_table.pubrt.id}"
}

output "prvrt_table_id"{
  value = "${aws_route_table.prvrt.*.id}"
}
