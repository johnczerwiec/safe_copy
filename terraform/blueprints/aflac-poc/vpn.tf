resource "aws_customer_gateway" "aflacpoc_gateway" {
    bgp_asn = 65510
    ip_address = "204.76.30.5"
    type = "ipsec.1"
        tags {
        Name = "Ensono-customer-gateway"
    }
}