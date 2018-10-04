
#-------------------------------------------
# VPC Peering Connection
#-------------------------------------------

data "aws_vpc_peering_connection" "aflacpoc-adminvpc-peering" {
  vpc_id = "${aws_vpc.vpc.id}"
  peer_cidr_block = "10.96.0.0/24"
  peer_vpc_id = "vpc-85e11ce3"
 
}
