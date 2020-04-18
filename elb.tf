resource "aws_instance" "ec2" {
  ami = var.amitype
  key_name = "custom-KP"
  vpc_security_group_ids = ["sg-0fdc9c8c32c542bfd"]
  subnet_id = "${element(var.subs,count.index)}"
  associate_public_ip_address = true
  instance_type = var.i_type
  availability_zone = "${element(var.azs,count.index)}"
  count = 2
  tags = {
    Name = "${var.project}-${count.index}"
  }
  }

resource "aws_lb" "test" {
  name               = var.nlb
  internal           = false
  load_balancer_type = var.lb_type
  subnets            = var.subs
  
  tags = {
     name= var.nlb
  }
}

resource "aws_lb_target_group" "ntg" {
  name     = var.tg
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc
}

resource "aws_lb_target_group_attachment" "ntg_attachment" {
  depends_on = ["aws_instance.ec2"]
  target_group_arn = "${aws_lb_target_group.ntg.arn}"
  count = length(var.azs)
  target_id        = element(aws_instance.ec2.*.id,count.index)
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "8080"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ntg.arn}"
  }
}
