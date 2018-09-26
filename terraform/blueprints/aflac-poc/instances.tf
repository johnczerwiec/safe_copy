#----------------------------------------------------- 
# windows_userdata
#----------------------------------------------------- 
resource "template_file" "windows_userdata" {
	template = "${file("/home/aflac-poc/git/terraform/blueprints/aflac-poc/files/windows_userdata.tpl")}"
    vars { s3_config_bucket = "${var.s3_bucket}" }
}

#----------------------------------------------------- 
# afl40gic01poc
#-----------------------------------------------------
resource "aws_instance" "gic01" {
# lifecycle { prevent_destroy = "true" }
  ami                   	 = "ami-0d2cde2c50d4d1fc2"
  instance_type          	 = "m5.4xlarge"
  key_name               	 = "${var.key_name}"
  vpc_security_group_ids	 = [ "${aws_security_group.ensono_mgmt.id}" ]
  subnet_id              	 = "${aws_subnet.PrivateSbA.id}"
  iam_instance_profile       = "${module.iam_role_Web.iam_instance_profile}"
  ebs_optimized         	 = "${var.ebs_opt_web}"
#  user_data 			 	 = "${data.template_file.windows_userdata.rendered}"
# disable_api_termination 	 = "true"

  tags {
    Name                 = "${var.ci_prefix}gic01${var.ci_suffix}"
    Description          = "${var.ci_suffix} App Instance"
    }
 root_block_device {
    volume_type = "gp2"
    volume_size = "500"
  }
}
