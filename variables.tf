
variable "cluster_config_file" {
  type        = string
  description = "Cluster config file for Kubernetes cluster."
}

variable "cluster_ingress_hostname" {
  type        = string
  description = "Ingress hostname of the IKS cluster."
}

variable "cluster_type" {
  description = "The cluster type (openshift or ocp3 or ocp4 or kubernetes)"
  default = "ocp4"
}

variable "tls_secret_name" {
  type        = string
  description = "The secret containing the tls certificates"
  default = ""
}

variable "sls_namespace" {
  type        = string
  description = "namespace for sls"
  default     = "ibm-sls"
}

variable "sls_key" {
  type        = string
  description = "ibm container entitlement key for sls"

}

variable "mongo_dbpass" {
  type        = string
  description = "mongodb password"
  sensitive = true

}

