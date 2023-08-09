provider "aws" {
  region     = "ap-south-1"
  
  
}

#Create a new EC2 launch configuration
resource "aws_instance" "WEB_public" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.ssh-security-group.id}"]
  subnet_id                   = aws_subnet.public-subnet-1.id
  user_data_path              = var.user_data_path
  associate_public_ip_address = true
  #user_data                   = "${data.template_file.provision.rendered}"
  #iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "WEB-PUBLIC"
  }
  
 
}
#Create a new EC2 launch configuration
resource "aws_instance" "DB_private" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.webserver-security-group.id}"]
  subnet_id                   = aws_subnet.private-subnet-1.id
  associate_public_ip_address = false
  #user_data                   = "${data.template_file.provision.rendered}"
  #iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "DB-PRIVATE"
  }
 
}
################################
 


