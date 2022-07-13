variable subnetid{
  type = list(string)
}

variable amiid{
  type = string
}

variable instancetype{
  type = string
  default = "t3.micro"
}

variable instancecount{
  type = number
}

variable instancename{
  type = string
}

variable securitygroup{
  type = string
}

variable roletag{
  type = string
}
