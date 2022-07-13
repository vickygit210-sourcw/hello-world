resource "aws_lb" "lb"{
  name = var.lbname
  internal = var.internal
  load_balancer_type = var.lbtype
  security_groups = var.lbsecuritygroupids
  subnets = var.subnetids

/*  enable_deletion_protection = true

  access_logs {
    bucket = aws_s3_bucket.lb_logs.bucket
    prefix = "test_lb"
    enabled = true
  }
*/
}

resource "aws_lb_target_group" "lbtg"{
  name = "${var.lbname}-tg"
  port = var.tgport
  protocol = var.insprotocol
  vpc_id = var.vpcid
}

resource "aws_lb_target_group_attachment" "lbtgass"{
  target_group_arn = aws_lb_target_group.lbtg.arn
  target_id = var.instanceid
  
}
