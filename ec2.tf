
resource "aws_instance" "public1" {
  ami                    = "ami-0d1ddd83282187d18"
  instance_type          = "t2.micro"
  subnet_id              = module.network.public_subnet1_id
  vpc_security_group_ids = ["${module.network.sg_1}"]
  key_name               = "key_pair"
  tags = {
    Name = "Bastion"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip}"
  }
}

resource "aws_instance" "private" {
  ami                    = "ami-0d1ddd83282187d18"
  instance_type          = "t2.micro"
  subnet_id              = module.network.private_subnet1_id
  vpc_security_group_ids = ["${module.network.sg_2}"]
  key_name               = "key_pair"
  tags = {
    Name = "Application"
  }


  provisioner "local-exec" {
    command = "echo ${self.private_ip}"
  }
}
