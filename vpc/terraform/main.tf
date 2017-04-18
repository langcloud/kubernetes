
// Create VPC
resource "aws_vpc" "vpc_kub" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  tags {
    Name = "${var.vpc_name}"
  }
}

// Create Public subnet for external access
resource "aws_subnet" "sn_public_1a" {
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.0.0/24"
  vpc_id            = "${aws_vpc.vpc_kub.id}"
  tags {
    Name = "sn_public_1a"
  }
}

//create private subnets in each AZ
resource "aws_subnet" "sn_private_1a" {
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.1.0/24"
  vpc_id            = "${aws_vpc.vpc_kub.id}"
  tags {
    Name = "sn_private_1a"
  }
}

resource "aws_subnet" "sn_private_1b" {
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.2.0/24"
  vpc_id            = "${aws_vpc.vpc_kub.id}"
  tags {
    Name = "sn_private_1b"
  }
}

resource "aws_subnet" "sn_private_1c" {
  availability_zone = "eu-west-1c"
  cidr_block        = "10.0.3.0/24"
  vpc_id            = "${aws_vpc.vpc_kub.id}"
  tags {
    Name = "sn_private_1c"
  }
}

// create internet Gateway
resource "aws_internet_gateway" "vpc_kub_gateway" {
  vpc_id = "${aws_vpc.vpc_kub.id}"
  tags {
    Name = "vpc_kub_gateway"
  }
}

// create eip for NAT
resource "aws_eip" "eip_vpc_kub_nat" {
  vpc = true
  depends_on = ["aws_internet_gateway.vpc_kub_gateway"]
}

//create nat gateway
resource "aws_nat_gateway" "nat_vpc_kub" {
  allocation_id = "${aws_eip.eip_vpc_kub_nat.id}"
  subnet_id     = "${aws_subnet.sn_public_1a.id}"
}

// create route to the internet
resource "aws_route" "rt_internet_vpc_kub" {
  route_table_id         = "${aws_vpc.vpc_kub.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.vpc_kub_gateway.id}"
}

// create private route table
resource "aws_route_table" "rt_nat_vpc_kub" {
  vpc_id = "${aws_vpc.vpc_kub.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_vpc_kub.id}"
  }
}

// route associations for public
resource "aws_route_table_association" "rt_ass_sn_public_1a" {
  subnet_id       = "${aws_subnet.sn_public_1a.id}"
  route_table_id  = "${aws_vpc.vpc_kub.main_route_table_id}"
}

// route associations for private_route
resource "aws_route_table_association" "rt_ass_sn_private_1a" {
  subnet_id = "${aws_subnet.sn_private_1a.id}"
  route_table_id = "${aws_route_table.rt_nat_vpc_kub.id}"
}

resource "aws_route_table_association" "rt_ass_sn_private_1b" {
  subnet_id = "${aws_subnet.sn_private_1b.id}"
  route_table_id = "${aws_route_table.rt_nat_vpc_kub.id}"
}

resource "aws_route_table_association" "rt_ass_sn_private_1c" {
  subnet_id = "${aws_subnet.sn_private_1c.id}"
  route_table_id = "${aws_route_table.rt_nat_vpc_kub.id}"
}
