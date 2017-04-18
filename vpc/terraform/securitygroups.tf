// create security group for ssh
resource "aws_security_group" "sg_bastion_ssh" {
  name        = "sg_bastion_ssh"
  description = "allow access to bastion on 22"
  vpc_id = "${aws_vpc.vpc_kub.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "sg_bastion_ssh"
  }
}

// create security group for etcd instances
resource "aws_security_group" "sg_etcd_cluster" {
  name        = "sg_etcd_cluster"
  description = "allow etcd cluster communication"
  vpc_id = "${aws_vpc.vpc_kub.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2379
    to_port     = 2379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2380
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4001
    to_port     = 4001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 7001
    to_port     = 7001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "sg_etcd_cluster"
  }
}

// create security group for k8ctrl instances - open for now
resource "aws_security_group" "sg_k8ctrl" {
  name        = "sg_k8ctrl"
  description = "controller instance security group"
  vpc_id = "${aws_vpc.vpc_kub.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "sg_k8ctrl"
  }
}

// create security group for k8worker instances - open for now
resource "aws_security_group" "sg_k8worker" {
  name        = "sg_k8worker"
  description = "worker security group"
  vpc_id = "${aws_vpc.vpc_kub.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "sg_k8worker"
  }
}

// create security group for k8ctrl elb instances - open for now
resource "aws_security_group" "sg_k8ctrl_elb" {
  name        = "sg_k8ctrl_elb"
  description = "api elb security group"
  vpc_id = "${aws_vpc.vpc_kub.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "sg_k8ctrl_elb"
  }
}
