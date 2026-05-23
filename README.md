# terraform-oci-fk-public-ip

This repository contains a reusable **Terraform/OpenTofu module** and progressive examples for deploying **Oracle Cloud Infrastructure (OCI) Public IP** resources in a clean, explicit, and architecture-aware way.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed as a dedicated **public IP identity building block** for OCI networking.

---

## Purpose

The goal of this repository is to provide a **clear, educational, and composable reference implementation** for OCI public IP addressing.

It focuses on:

- Public IP as a **first-class OCI networking resource**
- Explicit modeling of:
  - reserved versus ephemeral lifetime
  - optional attachment to a specific private IP
  - optional allocation from a public IP pool
  - reserved IP handoff to OCI services such as public load balancers
- Clean integration with:
  - regular compute instances
  - instance pools behind public load balancers
  - reusable VCN topologies

This is **not** a landing zone, platform framework, or full connectivity stack.  
It is a **learning-first building block** designed to integrate cleanly with other FoggyKitchen modules.

---

## What the module does

The module creates:

- one OCI public IP resource
- optional attachment to a specific private IP
- optional allocation from a public IP pool
- optional drift-tolerant mode for service-managed attachment workflows

The module intentionally does **not** create:

- VCNs or subnets
- Compute instances
- Load Balancers
- NAT Gateways
- DNS records

Each of those concerns belongs in its own dedicated module.

---

## Repository Structure

```bash
terraform-oci-fk-public-ip/
├── examples/
│   ├── 01_compute_reserved_public_ip/
│   ├── 02_loadbalancer_reserved_public_ip/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

All examples are runnable and demonstrate **incremental public IP patterns**, starting from direct compute attachment and progressing to reserved frontend IP usage for an OCI Load Balancer.

---

## Example Usage

### Reserved public IP attached to a compute instance

```hcl
module "public_ip" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-public-ip.git?ref=v1.0.0"

  name             = "fk-instance-public-ip"
  compartment_ocid = var.compartment_ocid
  private_ip_id    = var.private_ip_id
}
```

### Reserved public IP handed off to a public load balancer

```hcl
module "public_ip" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-public-ip.git?ref=v1.0.0"

  name                         = "fk-lb-public-ip"
  compartment_ocid             = var.compartment_ocid
  ignore_private_ip_id_changes = true
}

module "loadbalancer" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-loadbalancer.git?ref=v1.0.0"

  name                  = "fk-public-lb"
  compartment_ocid      = var.compartment_ocid
  subnet_ids            = [var.public_subnet_id]
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
```

---

## Module Inputs

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `name` | `string` | ✅ | Base display name used for the OCI public IP resource |
| `compartment_ocid` | `string` | ✅ | OCI compartment OCID |
| `display_name` | `string` | ❌ | Optional display name override |
| `lifetime` | `string` | ❌ | `RESERVED` or `EPHEMERAL`, `RESERVED` by default |
| `private_ip_id` | `string` | ❌ | Optional private IP OCID to which the public IP should be attached |
| `public_ip_pool_id` | `string` | ❌ | Optional public IP pool OCID |
| `ignore_private_ip_id_changes` | `bool` | ❌ | Ignore service-managed drift on `private_ip_id`, useful for public load balancer scenarios |
| `defined_tags` | `map(string)` | ❌ | Defined tags |
| `freeform_tags` | `map(string)` | ❌ | Freeform tags |

---

## Outputs

| Output | Description |
|------|-------------|
| `id` | OCI public IP OCID |
| `display_name` | Public IP display name |
| `ip_address` | Allocated public IP address |
| `lifetime` | Configured public IP lifetime |
| `private_ip_id` | Associated private IP OCID when attached |

---

## Design Philosophy

- Public IP should be **modeled explicitly**, not hidden inside unrelated service modules
- Public reachability and frontend identity are **architectural decisions**
- One module = one responsibility
- Reserved public IP ownership should remain **auditable and composable**

This repository intentionally avoids burying OCI public IP behavior behind unrelated networking abstractions.

---

## Related Modules & Training

- [terraform-oci-fk-compute](https://github.com/foggykitchen/terraform-oci-fk-compute)
- [terraform-oci-fk-loadbalancer](https://github.com/foggykitchen/terraform-oci-fk-loadbalancer)
- [terraform-oci-fk-vcn](https://github.com/foggykitchen/terraform-oci-fk-vcn)
- [terraform-az-fk-public-ip](https://github.com/mlinxfeld/terraform-az-fk-public-ip)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for details.

---

©(https://foggykitchen.com) - Cloud. Code. Clarity.
