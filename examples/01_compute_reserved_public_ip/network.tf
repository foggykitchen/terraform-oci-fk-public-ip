module "vcn" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-public-ip-compute-vcn"
  vcn_cidr_blocks  = ["10.50.0.0/16"]

  create_internet_gateway = true

  route_tables = {
    public = {
      route_rules = [
        {
          destination        = "0.0.0.0/0"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "internet_gateway"
        }
      ]
    }
  }

  security_lists = {
    public_compute = {
      ingress_rules = [
        {
          protocol = "6"
          source   = "0.0.0.0/0"
          tcp_options = {
            min = 22
            max = 22
          }
        },
        {
          protocol = "6"
          source   = "0.0.0.0/0"
          tcp_options = {
            min = 80
            max = 80
          }
        }
      ]
      egress_rules = [
        {
          protocol    = "all"
          destination = "0.0.0.0/0"
        }
      ]
    }
  }

  subnets = {
    public = {
      display_name               = "fk-public-ip-compute-subnet"
      cidr_block                 = "10.50.10.0/24"
      route_table_key            = "public"
      security_list_keys         = ["public_compute"]
      prohibit_public_ip_on_vnic = false
    }
  }
}
