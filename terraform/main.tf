# -------------------------------
# 1. Create k3d cluster
# -------------------------------

resource "k3d_cluster" "taskapi" {
    name = var.cluster_name
    servers = 1
    agents = 1
  
   port {
    host_port = "9000"
    container_port = "80"
    #node_filters = ["loadbalancer"]
  }
   kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = true
  }
}

#Fetch k3d cluster info
data "k3d_cluster" "taskapi" {
  name = k3d_cluster.taskapi.name
}

#Create local file to save the content of kubeconfig from the k3d cluster created
resource "local_file" "kubeconfig" {
  content = data.k3d_cluster.taskapi.kubeconfig_raw
  filename = "${path.module}/kubeconfig.yaml"  # Creates kubeconfig.yaml in the current module directory
    }  


# -------------------------------
# 2. Providers (use inline k3d kubeconfig)
# -------------------------------
provider "kubernetes" {
config_path = local_file.kubeconfig.filename
}

provider "helm" {
  kubernetes = {
    config_path = local_file.kubeconfig.filename
  }
}

# -------------------------------
# 3. Create namespace
# -------------------------------
resource "kubernetes_namespace" "taskapi" {
  metadata {
    name = var.namespace
  }
}

# -------------------------------
# 4. Deploy Helm Chart
# -------------------------------
resource "helm_release" "taskapi" {
  name      = "task-api"
  namespace = kubernetes_namespace.taskapi.metadata[0].name
  chart     = "${path.module}/../helm"

  values = [
    templatefile("${path.module}/values_override.yaml.tpl", {
      image_repo = var.image_repo,
      image_tag  = var.image_tag
    })
  ]

  depends_on = [
    k3d_cluster.taskapi, 
    local_file.kubeconfig
  ]
}

/*
resource "null_resource" "namespace" {
    depends_on = [ k3d_cluster.taskapi ]

    provisioner "local-exec" {
        command = "kubectl create namespace ${var.namespace} --dry-run=client -o yaml | kubectl apply -f -"
          }
  
}
*/