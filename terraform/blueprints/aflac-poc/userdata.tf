#----------------------------------------------------------------------
# Common userdata datasources used in server bluepritns
#----------------------------------------------------------------------

#-----------------------------------------------------
# windows_userdata
#-----------------------------------------------------
resource "template_file" "windows_userdata" {
  template = "${file("${path.module}/files/windows_userdata.tpl")}"
  vars { s3_bucket = "${var.s3_bucket}" }
}