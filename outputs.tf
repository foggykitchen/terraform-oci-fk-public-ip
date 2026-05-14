output "id" {
  description = "OCI public IP OCID."
  value       = var.ignore_private_ip_id_changes ? oci_core_public_ip.ignored_private_ip[0].id : oci_core_public_ip.managed[0].id
}

output "display_name" {
  description = "OCI public IP display name."
  value       = var.ignore_private_ip_id_changes ? oci_core_public_ip.ignored_private_ip[0].display_name : oci_core_public_ip.managed[0].display_name
}

output "ip_address" {
  description = "Allocated public IP address."
  value       = var.ignore_private_ip_id_changes ? oci_core_public_ip.ignored_private_ip[0].ip_address : oci_core_public_ip.managed[0].ip_address
}

output "lifetime" {
  description = "Configured OCI public IP lifetime."
  value       = var.ignore_private_ip_id_changes ? oci_core_public_ip.ignored_private_ip[0].lifetime : oci_core_public_ip.managed[0].lifetime
}

output "private_ip_id" {
  description = "Private IP OCID currently associated with the public IP, when applicable."
  value       = var.ignore_private_ip_id_changes ? oci_core_public_ip.ignored_private_ip[0].private_ip_id : oci_core_public_ip.managed[0].private_ip_id
}
