locals {
  bin_dir = module.setup_clis.bin_dir
  tmp_dir = "${path.cwd}/.tmp"
}


module setup_clis {
  source = "github.com/cloud-native-toolkit/terraform-util-clis.git"

  clis = ["helm"]
}

resource "null_resource" "deploy_catalog" {
  triggers = {
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/deployCatalog.sh"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${path.module}/scripts/deployCatalog.sh destroy"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }
}

# Service Binding Operator

resource "null_resource" "patchSBO" {
  triggers = {
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/patchSBO.sh"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

}

resource "null_resource" "entitlesecret" {
  depends_on = [
    null_resource.patchSBO
  ]

  triggers = {
    sls_namespace=var.sls_namespace
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "kubectl create secret docker-registry ibm-entitlement --docker-server=cp.icr.io --docker-username='cp' --docker-password=${var.sls_key} -n ${self.triggers.sls_namespace}"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }
  
  provisioner "local-exec" {
    when = destroy
    command = "kubectl delete secret docker-registry -n ${self.triggers.sls_namespace}"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }


}
