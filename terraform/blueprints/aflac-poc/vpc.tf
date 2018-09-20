resource "aws_vpc" "vpc" {
    lifecycle { prevent_destroy = "true" }
    cidr_block = "${var.cidr}"
    tags { Name = "${var.vpc_name}" }
    enable_dns_hostnames = true
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
}

# Virtual Gateway
resource "aws_vpn_gateway" "vgw" {
    vpc_id = "${aws_vpc.vpc.id}"
}

# Route Table
resource "aws_route_table" "Pubroutetable" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }    
    propagating_vgws = ["${aws_vpn_gateway.vgw.id}"]
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
        Name = "Private Subnet1"
    }
}

# Private Subnet2

resource "aws_subnet" "PrivateSbB" {
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}b"
    cidr_block = "${cidrsubnet(var.cidr,2,1)}"
    tags {
        Name = "Private Subnet2"
    }
}

resource "aws_route_table" "priroutetable" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.gw1.id}"
    }
	 
	propagating_vgws = [ "${aws_vpn_gateway.virtual_gateway.id}" ]
	
    tags { Name = "Private Route Table AZ-A" }
}

resource "aws_route_table_association" "PrivateSbA" {
    subnet_id = "${aws_subnet.PrivateSbA.id}"
    route_table_id = "${aws_route_table.priroutetable.id}"
}

resource "aws_route_table_association" "PrivateSbB" {
    subnet_id = "${aws_subnet.PrivateSbB.id}"
    route_table_id = "${aws_route_table.priroutetable.id}"
}