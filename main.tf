locals {
  bin_dir = module.setup_clis.bin_dir
  tmp_dir = "${path.cwd}/.tmp"
  ingress_subdomain = var.cluster_ingress_hostname

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

resource "null_resource" "entitlesecret" {
  depends_on = [
    null_resource.deploy_catalog

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

}

resource "null_resource" "mongopass" {
  depends_on = [
    null_resource.deploy_catalog
  ]

  triggers = {
    sls_namespace=var.sls_namespace
    sls_mongopw=var.mongo_dbpass
    sls_mongouid=var.mongo_userid

    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "kubectl create secret generic sls-mongo-credentials --from-literal=username=${self.triggers.sls_mongouid} --from-literal=password=${self.triggers.sls_mongopw} -n ${self.triggers.sls_namespace}"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

}

resource "null_resource" "deploy_licsub" {
    depends_on = [
    null_resource.mongopass
  ]
  
  triggers = {
    sls_namespace=var.sls_namespace
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/deployLICsub.sh ${self.triggers.sls_namespace}"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${path.module}/scripts/deployLICsub.sh ${self.triggers.sls_namespace} destroy"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }
}

resource "null_resource" "deploy_lic" {
    depends_on = [
    null_resource.deploy_licsub
  ]
  
  triggers = {
    ingress = local.ingress_subdomain
    sls_namespace=var.sls_namespace
    sls_sc=var.sls_storageClass
    mongo_namespace=var.mongo_namespace
    mongo_svc=var.mongo_svcname
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/deployLIC.sh ${self.triggers.ingress} ${self.triggers.sls_namespace} ${self.triggers.sls_sc} ${self.triggers.mongo_namespace} ${self.triggers.sls_sc} ${self.triggers.mongo_svc}"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${path.module}/scripts/deployLIC.sh null null null null null destroy"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }
}
