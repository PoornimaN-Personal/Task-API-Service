resource "kubernetes_namespace" "taskapi" {
     provider = kubernetes.eks
  metadata {
    name = "task-api-${var.env}"
  }

  depends_on = [
    module.eks
  ]
  
}
