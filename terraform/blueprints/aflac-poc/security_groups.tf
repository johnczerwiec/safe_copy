#------------------------------------------------------
# Ensono Management 
#------------------------------------------------------
resource "aws_security_group" "ensono_mgmt" {
  name = "ENSONO_MANAGEMENT"
  description = "Ensono_Management Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
  
  # SSH Access from Ensono Technical network over Direct Connect, and Jump-off server
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "10.96.0.0/24", "170.118.64.0/21" ]
  }
  
  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = [ "10.96.0.0/24", "170.118.64.0/21" ]
  } 
  
    ingress {
    from_port = 5986
    to_port = 5986
    protocol = "tcp"
    cidr_blocks = [ "10.96.0.0/24", "170.118.64.0/21", "10.0.0.0/8" ]
  } 
  
  # OUTBOUND
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
