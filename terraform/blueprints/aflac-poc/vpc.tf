#------------------------------------------- 
# Ensono Managed VPC - 4 subnets ( 2 public, 2 private) , internet gateway, 1 nat gateway.
#------------------------------------------- 

#------------------------------------------- 
# VPC
#------------------------------------------- 

resource "aws_vpc" "vpc" {
    lifecycle { prevent_destroy = "true" }
    cidr_block = "${var.cidr}"
    tags { Name = "${var.vpc_name}" }
    enable_dns_hostnames = true
}

#------------------------------------------- 
# Internet Gateway
#------------------------------------------- 

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.vpc.id}"
}

#-------------------------------------------
# Virtual Gateway
#-------------------------------------------

resource "aws_vpn_gateway" "virtual_gateway" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
      Name = "${var.env} vpg"
    }
}

#------------------------------------------- 
# Nat Gateway
#------------------------------------------- 

resource "aws_eip" "nat1" {
    vpc = true
}

resource "aws_nat_gateway" "gw1" {
    allocation_id = "${aws_eip.nat1.id}"
    subnet_id = "${aws_subnet.publicAzA.id}"
}


#------------------------------------------- 
# Public Subnets
#------------------------------------------- 

resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
	}
	propagating_vgws = [ "${aws_vpn_gateway.virtual_gateway.id}" ] 
    tags { Name = "Public Route Table" }
}

resource "aws_subnet" "publicAzA" {
    lifecycle { prevent_destroy = "True" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}a"
    cidr_block = "${cidrsubnet(var.cidr,3,0)}"
    tags { Name = "Public Subnet AzA" }
}

resource "aws_subnet" "publicAzB" {
    lifecycle { prevent_destroy = "True" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}b"
    cidr_block = "${cidrsubnet(var.cidr,3,1)}"
    tags { Name = "Public Subnet AzB" }
}

resource "aws_route_table_association" "publicAzA" {
    subnet_id = "${aws_subnet.publicAzA.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "publicAzB" {
    subnet_id = "${aws_subnet.publicAzB.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}


#------------------------------------------- 
# Private Subnets
#------------------------------------------- 

resource "aws_subnet" "privateAzA" {
    lifecycle { prevent_destroy = "True" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}a"
    cidr_block = "${cidrsubnet(var.cidr,3,3)}"
    tags { Name = "Private Subnet AzA" }
}

resource "aws_subnet" "privateAzB" {
    lifecycle { prevent_destroy = "True" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}b"
    cidr_block = "${cidrsubnet(var.cidr,3,4)}"
    tags { Name = "Private Subnet AzB" }
}

resource "aws_route_table" "private_route_table_AzA" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.gw1.id}"
    }
	 
	propagating_vgws = [ "${aws_vpn_gateway.virtual_gateway.id}" ]
	
    tags { Name = "Private Route Table AZ-A" }
}

resource "aws_route_table_association" "privateAzA" {
    subnet_id = "${aws_subnet.privateAzA.id}"
    route_table_id = "${aws_route_table.private_route_table_AzA.id}"
}

resource "aws_route_table_association" "privateAzB" {
    subnet_id = "${aws_subnet.privateAzB.id}"
    route_table_id = "${aws_route_table.private_route_table_AzA.id}"
}


