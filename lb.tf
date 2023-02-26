resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

resource "aws_lb" "Application" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["${module.network.public_subnet1_id}","${module.network.public_subnet2_id}"]

}

resource "aws_lb_target_group" "lb_App_tg" {
  name     = "application"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id

  health_check {
    path   = "/redis"
  }

}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.lb_App_tg.arn
  target_id        = aws_instance.private.id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.Application.arn
  port         = "80"
  protocol     = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_App_tg.arn
  }
}
