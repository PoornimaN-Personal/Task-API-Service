
# -------------------------------
# 4. Deploy Helm Chart
# -------------------------------
resource "helm_release" "taskapi" {
  provider = helm.eks
  name       = "taskapi"
  namespace  = kubernetes_namespace.taskapi.metadata[0].name
  chart      = "${path.module}/../helm"
  version    = var.chart_version

  values = [
    templatefile("${path.module}/values_override.yaml.tpl", {
      image_repo = var.image_repo,
      image_tag  = var.image_tag
    })
  ]

  depends_on = [
    module.eks,
    kubernetes_namespace.taskapi
  ]
}