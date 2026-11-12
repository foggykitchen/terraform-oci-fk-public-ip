module "public_ip" {
  source = "../.."

  name                         = "fk-loadbalancer-reserved-public-ip"
  compartment_ocid             = var.compartment_ocid
  ignore_private_ip_id_changes = true
}
