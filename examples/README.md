# OCI Public IP with Terraform/OpenTofu - Training Examples

This directory contains runnable examples for the **terraform-oci-fk-public-ip** module.
The examples focus on practical OCI public IP deployment patterns, from direct instance attachment to reserved frontend IP usage for a public load balancer.

These examples are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used across OCI and multicloud courses covering networking, compute, traffic distribution, and architecture fundamentals.

---

## Published Examples

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **Reserved Public IP for Compute** | reserved OCI public IP, direct attachment to instance private IP, `terraform-oci-fk-compute` integration |
| 02 | **Reserved Public IP for Load Balancer** | reserved OCI public IP, public load balancer frontend, instance pool backend, `terraform-oci-fk-loadbalancer` and `terraform-oci-fk-compute` integration |

---

## How to Use

The example directory contains:
- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A minimal, runnable architecture

To run the compute attachment example:

```bash
cd examples/01_compute_reserved_public_ip
tofu init
tofu plan
tofu apply
```

To run the load balancer frontend example:

```bash
cd examples/02_loadbalancer_reserved_public_ip
tofu init
tofu plan
tofu apply
```

---

## Design Principles

- One example = one architectural goal
- No unused or placeholder resources
- Clear separation of concerns between networking, public addressing, compute, and load balancing
- Examples designed to integrate with other modules such as VCN, Compute, and Load Balancer

---

## Related Resources

- [FoggyKitchen OCI Public IP Module (terraform-oci-fk-public-ip)](../)
- [FoggyKitchen OCI Compute Module (terraform-oci-fk-compute)](https://github.com/foggykitchen/terraform-oci-fk-compute)
- [FoggyKitchen OCI Load Balancer Module (terraform-oci-fk-loadbalancer)](https://github.com/foggykitchen/terraform-oci-fk-loadbalancer)
- [FoggyKitchen OCI VCN Module (terraform-oci-fk-vcn)](https://github.com/foggykitchen/terraform-oci-fk-vcn)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../LICENSE) for details.

---

© 2026 FoggyKitchen.com - Cloud. Code. Clarity.
