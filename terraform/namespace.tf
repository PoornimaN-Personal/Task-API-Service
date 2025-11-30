resource "kubernetes_namespace" "taskapi" {
     provider = kubernetes.eks
  metadata {
    name = var.namespace
  }

  depends_on = [
    module.eks
  ]
}
