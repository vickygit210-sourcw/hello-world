
# Security Groups
module devopsg{
  source = "../AWS/Network/securitygroup"
  sgname = "devops_sg"
  sgdescription = "Devops Security Group"
  vpcid = "vpc-0ab698e56e0d242ec"
  ingressrules =  [{
    port = 8082
    description = "http for helloworld"
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

module web{
  source = "../AWS/Compute"
  subnetid = "subnet-087b7d2a7eee819d9"
  amiid = "ami-0c94855ba95c71c99"
  instancecount = 1
  instancename = "web"
  securitygroup = module.devopsg.securitygrpid
}
