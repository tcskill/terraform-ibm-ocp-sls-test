#  IBM SLS terraform module

Deploys IBM Suite License Service on RedHat OpenShift

## Supported platforms

- OCP 4.6+

## Module dependencies

The module uses the following elements

### Terraform providers

- helm - used to configure the scc for OpenShift
- null - used to run the shell scripts

### Environment

- kubectl - used to apply yaml 

## Suggested companion modules

The module itself requires some information from the cluster and needs a
namespace to be created. The following companion
modules can help provide the required information:

- Cluster - https://github.com/ibm-garage-cloud/terraform-cluster-ibmcloud
- Namespace - https://github.com/ibm-garage-cloud/terraform-cluster-namespace

## Example usage

```hcl-terraform
module "mas_sls" {
  source = "github.com/tcskill/terraform-ibm-ocp-sls-test"

  cluster_config_file      = module.cluster.config_file_path
  cluster_type             = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  tls_secret_name          = module.cluster.platform.tls_secret
  
  sls_namespace = var.mysls_namespace
  sls_key       = var.mysls_key
  mongo_dbpass  = var.mymongo_dbpass

}
```

