#  IBM SLS terraform module

![Verify and release module](https://github.com/cloud-native-toolkit/terraform-ibm-ocp-sls/workflows/Verify%20and%20release%20module/badge.svg)

Deploys IBM Suite License Service on RedHat OpenShift.  This modules requires mongodb-ce instance on the OpenShift cluster.

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
- Mongo - https://github.com/cloud-native-toolkit/terraform-ocp-mongodb

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

