// create bastion host and supporting config

resource "aws_instance" "bastion_host" {
  ami                     = "ami-405f7226"
  availability_zone       = "eu-west-1a"
  instance_type           = "t2.micro"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${aws_security_group.sg_bastion_ssh.id}"]
  subnet_id               = "${aws_subnet.sn_public_1a.id}"
  source_dest_check       = false
  monitoring              = true
  tags {
    Name = "Bastion_Host_1a"
  }
}

// create static eip
resource "aws_eip" "bastion_eip" {
  vpc = true
  instance = "${aws_instance.bastion_host.id}"
}
