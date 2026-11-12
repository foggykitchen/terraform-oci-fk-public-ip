module "public_ip" {
  source = "../.."

  name             = "fk-compute-reserved-public-ip"
  compartment_ocid = var.compartment_ocid
  private_ip_id    = data.oci_core_private_ips.instance_primary.private_ips[0].id
}
