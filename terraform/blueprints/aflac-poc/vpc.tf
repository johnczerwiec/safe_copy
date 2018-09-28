resource "aws_vpc" "vpc" {
    lifecycle { prevent_destroy = "true" }
    cidr_block = "${var.cidr}"
    tags { Name = "${var.vpc_name}" }
    enable_dns_hostnames = true
}

#------------------------------------------- 
# VPC Peering Connection
#------------------------------------------- 

resource "aws_vpc_peering_connection" "vpc_pcx_ensmgmt" {
  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  peer_region   = "${var.peer_region}"
  vpc_id        = "${aws_vpc.vpc.id}"
  #auto_accept   = true

  tags {

    Name = "VPC Peering between Aflac POC and ens-mgmt"
  }
}

#------------------------------------------- 
# Internet Gateway
#------------------------------------------- 

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
}

#------------------------------------------- 
# Virtual Gateway
#------------------------------------------- 

resource "aws_vpn_gateway" "vgw" {
   amazon_side_asn = 65070
   vpc_id = "${aws_vpc.vpc.id}"
    tags {
      Name = "${var.env} vpg"
    }
}

# Route Table
resource "aws_route_table" "Pubroutetable" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }    
    propagating_vgws = ["${aws_vpn_gateway.vgw.id}"]
	tags { Name = "Public Route Table" }
}

# Public Subnet 1
resource "aws_subnet" "PublicSbA" {
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}a"
    cidr_block = "${cidrsubnet(var.cidr,2,2)}"
    tags {
        Name = "Public SubnetA"
    }
}

# Public Subnet 2
resource "aws_subnet" "PublicSbB" {
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}b"
    cidr_block = "${cidrsubnet(var.cidr,2,3)}"
    tags {
        Name = "Public SubnetB"
    }
}

# Route Table association

resource "aws_route_table_association" "PublicSbA" {
    subnet_id = "${aws_subnet.PublicSbA.id}"
    route_table_id = "${aws_route_table.Pubroutetable.id}"
}

resource "aws_route_table_association" "PublicSbB" {
    subnet_id = "${aws_subnet.PublicSbB.id}"
    route_table_id = "${aws_route_table.Pubroutetable.id}"
}

# NAT Gateway

resource "aws_eip" "ngip" {
    vpc = true
    tags {
        Name = "NAT Gateway"
    }
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = "${aws_eip.ngip.id}"
    subnet_id = "${aws_subnet.PublicSbA.id}"
}

# Private Subnet1

resource "aws_subnet" "PrivateSbA" {
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}a"
    cidr_block = "${cidrsubnet(var.cidr,2,0)}"
    tags {
        Name = "Private SubnetA"
    }
}



# Private Subnet2

resource "aws_subnet" "PrivateSbB" {
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}b"
    cidr_block = "${cidrsubnet(var.cidr,2,1)}"
    tags {
        Name = "Private SubnetB"
    }
}

resource "aws_route_table" "priroutetable" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.ngw.id}"
    }
    route {
    cidr_block = "${var.cidr_ensmgmt}"
    gateway_id = "${aws_vpc_peering_connection.vpc_pcx_ensmgmt.id}"
    }	
	propagating_vgws = [ "${aws_vpn_gateway.vgw.id}" ]
	tags { Name = "Private Route Table" }
}


resource "aws_route_table_association" "PrivateSbA" {
    subnet_id = "${aws_subnet.PrivateSbA.id}"
    route_table_id = "${aws_route_table.priroutetable.id}"
}

resource "aws_route_table_association" "PrivateSbB" {
    subnet_id = "${aws_subnet.PrivateSbB.id}"
    route_table_id = "${aws_route_table.priroutetable.id}"
}