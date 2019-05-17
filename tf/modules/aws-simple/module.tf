######################################################################
# Common AWS settings

# Given a region
provider "aws" {
  region = "${var.region}"
}

# Get list of availabily zones
data "aws_availability_zones" "azs" {
  state = "available"
}

# Choose most recent debian stretch image
data "aws_ami" "image" {
  most_recent = true
  owners      = ["379101102735"]
  filter {
    name   = "name"
    values = ["debian-stretch-hvm-x86_64-gp2-*"]
  }
}

######################################################################
# Elastic IP
data "aws_eip" "seed_eip" {
  count     = "${var.use_eip}"
  public_ip = "${var.seed_eip}"
}

resource "aws_eip_association" "codaserver" {
  count         = "${var.use_eip}"
  instance_id   = "${aws_instance.codaserver.id}"
  allocation_id = "${data.aws_eip.seed_eip.id}"
}


######################################################################

resource "aws_instance" "codaserver" {
  count                  = "${var.server_count}"
  ami                    = "${data.aws_ami.image.id}"
  instance_type          = "${var.instance_type}"
  security_groups        = ["${var.security_group}"]
  key_name               = "testnet"
  availability_zone      = "${element(data.aws_availability_zones.azs.names, count.index)}"
  iam_instance_profile   = "${var.iam_instance_profile}"

  tags {
    Name      = "${var.netname}_${var.region}_${var.rolename}_${count.index}"
  }

  # Default root is 8GB
  root_block_device {
      volume_size = 32
  }

  # Role Specific Magic Happens Here
  user_data = <<-EOF
#!/bin/bash
echo "Setting hostname"
hostnamectl set-hostname ${var.netname}_${var.region}_${var.rolename}_${count.index}.${var.region}
echo '127.0.1.1  ${var.netname}_${var.region}_${var.rolename}_${count.index}.${var.region}' >> /etc/hosts

# coda flags
echo ${var.rolename} > /etc/coda-rolename

# journal logs on disk
mkdir /var/log/journal

# user tools
apt-get --yes install emacs-nox htop lsof ncdu tmux ttyload dnsutils rsync jq bc

# dev tools
apt-get --yes install python3-pip
pip3 install sexpdata psutil

  EOF

}