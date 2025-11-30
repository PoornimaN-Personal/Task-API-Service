variable "aws_region" {
  default = "ap-southeast-2"
}

variable "cluster_name" {
  type = string
  description = "Name of the k3d cluster"
  default = "taskapi-cluster"
}

variable "namespace" {
  type = string
  description = "kubernetes namespace for deploying app"
  default = "task-api"
}

variable "helm_chart_path" {
  description = "Path to your local Helm chart"
  default = "./helm"
}

variable "values_file_path" {
  description = "Optional values file"
  default     = "./helm/values.yaml"
}
variable "chart_version" {
  default = "0.1.0"
}

variable "image_repo" {
  description = "Container image repository"
  default     = "ghcr.io/poorniman-personal/task-api"
}

variable "image_tag" {
  description = "Container image tag"
  default     = "latest"
}