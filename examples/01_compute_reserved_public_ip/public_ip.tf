module "public_ip" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-public-ip.git?ref=v1.0.0"

  name             = "fk-compute-reserved-public-ip"
  compartment_ocid = var.compartment_ocid
  private_ip_id    = data.oci_core_private_ips.instance_primary.private_ips[0].id
}
