# ${path.module} is an interpolated string in Terraform, which references the path to the current
# module. In this case, it returns the path to the directory containing the current module.

data "local_file" "kubeconfig" {
  depends_on = [module.gke_auth]
  filename = "${path.module}/kubeconfig"
}

output "kubeconfig" {
  value       = "${path.module}/kubeconfig"
  description = "The path to the kubeconfig file"
}

output "kubeconfig_content" {
  description = "The content of the kubeconfig file for the created cluster."
  value       = data.local_file.kubeconfig.content
  sensitive   = true
}