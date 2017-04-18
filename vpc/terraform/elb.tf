// ELB for k8ctrl instances
resource "aws_elb" "lb-k8ctrl" {

  name = "lb-k8ctrl"
  availability_zones = ["eu-west-1a"]
  subnets = ["${aws_subnet.sn_private_1a.id}"]
  instances = ["${aws_instance.k8ctrl.*.id}"]
  security_groups = ["${aws_security_group.sg_k8ctrl_elb.id}"]

  listener {
    lb_port = 6443
    instance_port = 6443
    lb_protocol = "TCP"
    instance_protocol = "TCP"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 15
    target = "HTTP:8080/healthz"
    interval = 30
  }

  tags {
    Name = "lb-k8ctrl"
  }
}
