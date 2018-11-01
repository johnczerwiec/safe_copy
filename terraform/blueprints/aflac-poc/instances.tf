#----------------------------------------------------- 
# afl40gic01poc
#-----------------------------------------------------
resource "aws_instance" "gic01" {
# lifecycle { prevent_destroy = "true" }
  ami                   	 = "ami-0d2cde2c50d4d1fc2"
  instance_type          	 = "m5.4xlarge"
  key_name               	 = "${var.key_name}"
  vpc_security_group_ids	 = [ "${aws_security_group.ensono_mgmt.id}", "${aws_security_group.cust_sg.id}" ]
  subnet_id              	 = "${aws_subnet.PrivateSbA.id}"
  iam_instance_profile       = "${module.iam_role_Web.iam_instance_profile}"
  ebs_optimized         	 = "${var.ebs_opt_web}"
  user_data 			 	 = "${template_file.windows_userdata.rendered}"
# disable_api_termination 	 = "true"

  tags {
    Name                 = "${var.ci_prefix}gic01${var.ci_suffix}"
    Description          = "${var.ci_suffix} App Instance"
    }
 root_block_device {
    volume_type = "gp2"
    volume_size = "500"
  }
 ebs_block_device {
    device_name = "xvdb"
    volume_type = "gp2"
    volume_size = "50"
  }
}

#----------------------------------------------------- 
# afl40gic02poc
#-----------------------------------------------------
#resource "aws_instance" "gic02" {
# lifecycle { prevent_destroy = "true" }
#  ami                   	 = "ami-0370e5bf38d26e2cb"
#  instance_type          	 = "m5.4xlarge"
#  key_name               	 = "${var.key_name}"
#  vpc_security_group_ids	 = [ "${aws_security_group.ensono_mgmt.id}", "${aws_security_group.cust_sg.id}" ]
#  subnet_id              	 = "${aws_subnet.PrivateSbA.id}"
#  iam_instance_profile       = "${module.iam_role_Web.iam_instance_profile}"
#  ebs_optimized         	 = "${var.ebs_opt_web}"
#  user_data 			 	 = "${template_file.windows_userdata.rendered}"
# disable_api_termination 	 = "true"

# tags {
#    Name                 = "${var.ci_prefix}gic02${var.ci_suffix}"
#    Description          = "${var.ci_suffix} App Instance"
#    }
# root_block_device {
#    volume_type = "gp2"
#    volume_size = "500"
#  }
# ebs_block_device {
#    device_name = "xvdb"
#    volume_type = "gp2"
#    volume_size = "50"
#  }
#}



#----------------------------------------------------- 
# afl40gicmdb01poc
#-----------------------------------------------------
resource "aws_instance" "gicmdb01" {
# lifecycle { prevent_destroy = "true" }
  ami                   	 = "ami-0d2cde2c50d4d1fc2"
  instance_type          	 = "m5.4xlarge"
  key_name               	 = "${var.key_name}"
  vpc_security_group_ids	 = [ "${aws_security_group.ensono_mgmt.id}", "${aws_security_group.cust_sg.id}" ]
  subnet_id              	 = "${aws_subnet.PrivateSbA.id}"
  iam_instance_profile       = "${module.iam_role_Web.iam_instance_profile}"
  ebs_optimized         	 = "${var.ebs_opt_web}"
  user_data 			 	 = "${template_file.windows_userdata.rendered}"
 disable_api_termination 	 = "true"

  tags {
    Name                 = "${var.ci_prefix}gicmdb01${var.ci_suffix}"
    Description          = "${var.ci_suffix} App Instance"
    }
 root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }
 ebs_block_device {
    device_name = "xvdb"
    volume_type = "gp2"
    volume_size = "80"
  }
}

#--------------------------------------------------------------------------------------
# afl40gic02poc,afl40gic03poc,afl40gic04poc & afl40gic05poc - from ami of afl40gic02poc (11/01)
#---------------------------------------------------------------------------------------
resource "aws_instance" "gic" {
# lifecycle { prevent_destroy = "true" }
  count = "${var.gic_count}"
  ami                   	 = "${var.gic_type_ami}"
  instance_type          	 = "${var.gic_type}"
  key_name               	 = "${var.key_name}"
  vpc_security_group_ids	 = [ "${aws_security_group.ensono_mgmt.id}", "${aws_security_group.cust_sg.id}" ]
#  subnet_id              	 = "${aws_subnet.PrivateSbA.id}"
 subnet_id              	 = "${element(var.private_subnet_list, count.index)}"
  iam_instance_profile       = "${module.iam_role_Web.iam_instance_profile}"
  ebs_optimized         	 = "${var.ebs_opt_web}"
  user_data 			 	 = "${template_file.windows_userdata.rendered}"
#  disable_api_termination 	 = "true"

  tags {
    Name                 = "${var.ci_prefix}gic0${count.index+2}${var.ci_suffix}"
    Description          = "${var.ci_suffix} App Instance${count.index+2}"
    }
 root_block_device {
    volume_type = "gp2"
    volume_size = "500"
  }
 ebs_block_device {
    device_name = "xvdb"
	delete_on_termination = "true"
	volume_type = "gp2"
    volume_size = "50"
  }
}


