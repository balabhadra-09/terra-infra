resource "aws_key_pair" "my_key_pair" {
    key_name = "my_key_pair"
    public_key = file("my-terra-key.pub")
  
}

resource "aws_default_vpc" "my_vpc" {

}


 

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "my_security_group"
  vpc_id      = aws_default_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}

 resource "aws_instance" "my_instance" {
  count = 4
   ami = var.ami_id
   instance_type = var.instance_type
   security_groups = [aws_security_group.my_security_group.name]
   key_name = aws_key_pair.my_key_pair.key_name
   user_data = file("install.sh")

   root_block_device {
     volume_size = 10
     volume_type = "gp3"
   }
   tags = {
     name = "node-${count.index}"
   }
 }