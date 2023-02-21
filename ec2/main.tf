provider "aws" {
  region = local.region
}

locals {
  name   = "ex-${replace(basename(path.cwd), "_", "-")}"
  region = "eu-west-1"
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  for_each = toset(["one", "two"])

  name = "instance-${each.key}"

  ami                    = data.aws_ami.amazon_linux.id
  availability_zone      = "eu-west-1a"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true


  placement_group = aws_placement_group.web.id
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 50
    }
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      encrypted   = true
    }
  ]

  #associate_public_ip_address = true
  #private_ip = "xxxx"
  #secondary_private_ips = "xx"
  #subnet_id              = "subnet-eddcdzz4"
  #vpc_security_group_ids = ["sg-12345678"]
  network_interface = [ //can't be specified together with vpc_security_group_ids, associate_public_ip_address, subnet_id
    {
        device_index          = 0
        network_interface_id  = aws_network_interface.ni[each.key].id
        delete_on_termination = false
    }
   ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_placement_group" "web" {
  name     = local.name
  strategy = "partition"
}

resource "aws_network_interface" "ni" {
  for_each = toset(["one", "two"])
  description = "network-${each.key}"
  subnet_id   = "subnet-08ae13a4f87cb1f6c"
  private_ips_count = 2
}

output "network_ids" {
  value = {
    for k, v in aws_network_interface.ni : 
    k => v.id
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}