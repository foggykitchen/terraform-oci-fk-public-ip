locals {
  public_ip_name = coalesce(var.display_name, var.name)
}

resource "oci_core_public_ip" "managed" {
  count = var.ignore_private_ip_id_changes ? 0 : 1

  compartment_id    = var.compartment_ocid
  display_name      = local.public_ip_name
  lifetime          = var.lifetime
  private_ip_id     = var.private_ip_id
  public_ip_pool_id = var.public_ip_pool_id
  defined_tags      = var.defined_tags
  freeform_tags     = var.freeform_tags

  lifecycle {
    precondition {
      condition     = var.lifetime != "EPHEMERAL" || var.private_ip_id != null
      error_message = "private_ip_id must be provided when lifetime is set to EPHEMERAL."
    }
  }
}

resource "oci_core_public_ip" "ignored_private_ip" {
  count = var.ignore_private_ip_id_changes ? 1 : 0

  compartment_id    = var.compartment_ocid
  display_name      = local.public_ip_name
  lifetime          = var.lifetime
  private_ip_id     = var.private_ip_id
  public_ip_pool_id = var.public_ip_pool_id
  defined_tags      = var.defined_tags
  freeform_tags     = var.freeform_tags

  lifecycle {
    ignore_changes = [private_ip_id]

    precondition {
      condition     = var.lifetime != "EPHEMERAL" || var.private_ip_id != null
      error_message = "private_ip_id must be provided when lifetime is set to EPHEMERAL."
    }
  }
}
