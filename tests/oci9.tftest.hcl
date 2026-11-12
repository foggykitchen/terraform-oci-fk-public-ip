# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_resource "oci_core_public_ip" {
    defaults = { "assigned_entity_id" = "MOCK_OCID_MOCK", "assigned_entity_type" = "mock-value", "availability_domain" = "MOCK:EU-FRANKFURT-1-AD-1", "id" = "MOCK_OCID_IP", "ip_address" = "10.0.0.10", "scope" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
}
variables {
  name             = "compatibility"
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
}

run "oci9_plan" {
  command = plan
}
