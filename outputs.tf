output "sls_key" {
  value       = data.local_file.slskey.content
  description = "license key for SLS"
  depends_on  = [
    null_resource.deploy_lic
  ]
}

output "sls_namespace" {
  value       = var.sls_namespace
  description = "Namespace sls is located in cluster"
  depends_on  = [
    null_resource.deploy_lic
  ]
}
