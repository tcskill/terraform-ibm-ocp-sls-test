module "dev_tools_namespace" {
  source = "github.com/ibm-garage-cloud/terraform-cluster-namespace?ref=v3.1.2"

  cluster_config_file_path = module.dev_cluster.config_file_path
  name                     = var.mysls_namespace
  create_operator_group = false
}


resource null_resource write_namespace {
  provisioner "local-exec" {
    command = "echo '${var.mysls_namespace}' > ${path.cwd}/sls_namespace"
  }
}
