// create controller instnaces

resource "aws_instance" "k8ctrl" {
  count = 3
  ami                     = "ami-405f7226"
  availability_zone       = "eu-west-1a"
  instance_type           = "t2.micro"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${aws_security_group.sg_k8ctrl.id}"]
  subnet_id               = "${aws_subnet.sn_private_1a.id}"
  source_dest_check       = false
  monitoring              = true
  tags {
    Name = "k8ctrl-${count.index}"
  }
}

// create etcd instnaces

resource "aws_instance" "etcd" {
  count = 3
  ami                     = "ami-405f7226"
  availability_zone       = "eu-west-1a"
  instance_type           = "t2.micro"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${aws_security_group.sg_etcd_cluster.id}"]
  subnet_id               = "${aws_subnet.sn_private_1a.id}"
  source_dest_check       = false
  monitoring              = true
  tags {
    Name = "etcd-${count.index}"
  }
}

// create worker instances

resource "aws_instance" "k8worker" {
  count = 3
  ami                     = "ami-405f7226"
  availability_zone       = "eu-west-1a"
  instance_type           = "t2.micro"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${aws_security_group.sg_k8worker.id}"]
  subnet_id               = "${aws_subnet.sn_private_1a.id}"
  source_dest_check       = false
  monitoring              = true
  tags {
    Name = "k8worker-${count.index}"
  }
}
