module "loadbalancer" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-loadbalancer.git?ref=v1.0.0"

  name                  = "fk-public-ip-lb"
  compartment_ocid      = var.compartment_ocid
  subnet_ids            = [module.vcn.subnet_ids["fk_lb_public_subnet"]]
  reserved_public_ip_id = module.public_ip.id

  health_checker = {
    protocol = "HTTP"
    port     = 80
    url_path = "/"
  }

  listener = {
    name     = "http"
    port     = 80
    protocol = "HTTP"
  }
}
