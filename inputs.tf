variable "name" {
  description = "Base display name used for the OCI public IP resource."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "name must not be empty."
  }
}

variable "compartment_ocid" {
  description = "Compartment OCID where the public IP resource will be created."
  type        = string
}

variable "display_name" {
  description = "Optional display name override for the public IP."
  type        = string
  default     = null
}

variable "lifetime" {
  description = "OCI public IP lifetime. RESERVED is the default and recommended option for reusable public addressing."
  type        = string
  default     = "RESERVED"

  validation {
    condition     = contains(["RESERVED", "EPHEMERAL"], var.lifetime)
    error_message = "lifetime must be either RESERVED or EPHEMERAL."
  }
}

variable "private_ip_id" {
  description = "Optional private IP OCID to which the public IP should be attached."
  type        = string
  default     = null
}

variable "public_ip_pool_id" {
  description = "Optional public IP pool OCID used when allocating the public IP from a specific pool."
  type        = string
  default     = null
}

variable "ignore_private_ip_id_changes" {
  description = "Ignore drift on private_ip_id after creation. Useful when another OCI service, such as a public load balancer, claims the reserved IP."
  type        = bool
  default     = false
}

variable "defined_tags" {
  description = "Defined tags applied to the public IP resource."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags applied to the public IP resource."
  type        = map(string)
  default     = {}
}
