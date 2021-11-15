module "sls" {
  source = "./module"

  cluster_config_file      = module.dev_cluster.config_file_path
  cluster_type             = module.dev_cluster.platform.type_code
  cluster_ingress_hostname = module.dev_cluster.platform.ingress
  tls_secret_name          = module.dev_cluster.platform.tls_secret
  
  sls_namespace   = module.dev_sls_namespace.name
  sls_key         = var.sls_key
  mongo_dbpass    = module.dev_mongo.mongo_dbpass
  mongo_namespace = module.dev_mongo.mongo_namespace
  mongo_svcname   = module.dev_mongo.mongo_svcname
  
}
