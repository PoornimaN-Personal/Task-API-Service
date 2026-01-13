resource "kind_cluster" "local" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    node {
      role = "worker"
    }
  }
}


resource "kubernetes_namespace_v1" "taskapi" {
    provider = kubernetes.namespace
    metadata {
      name = var.namespace
    }
  depends_on = [ kind_cluster.local ]
}

resource "helm_release" "taskapi" {
    provider = helm.release
    name = "taskapi-local"
    namespace = kubernetes_namespace_v1.taskapi.metadata[0].name
    chart = "${path.module}/../../helm"
    version = var.chart_version
values = [
    templatefile("${path.module}/../values_override.yaml.tpl", {
      image_repo = var.image_repo,
      image_tag  = var.image_tag
    })
  ]
  
depends_on = [ kind_cluster.local,
kubernetes_namespace_v1.taskapi
 ]
}