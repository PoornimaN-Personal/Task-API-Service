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

variable "image_repo" {
  description = "Container image repository"
  default     = "ghcr.io/poorniman-personal/task-api"
}

variable "image_tag" {
  description = "Container image tag"
  default     = "latest"
}