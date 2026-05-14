output "instance_id" {
  value = module.compute.instance_id
}

output "instance_private_ip" {
  value = module.compute.instance_private_ip
}

output "reserved_public_ip_id" {
  value = module.public_ip.id
}

output "reserved_public_ip_address" {
  value = module.public_ip.ip_address
}

output "vcn_id" {
  value = module.vcn.vcn_id
}
