module "sls" {
  source = "./module"

  cluster_config_file      = module.dev_cluster.config_file_path
  cluster_type             = module.dev_cluster.platform.type_code
  cluster_ingress_hostname = module.dev_cluster.platform.ingress
  tls_secret_name          = module.dev_cluster.platform.tls_secret
  
  sls_namespace = var.sls_namespace
  sls_key = var.sls_key
  mongo_dbpass=var.mongo_dbpass

}
