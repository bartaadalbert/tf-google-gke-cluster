# ${path.module} is an interpolated string in Terraform, which references the path to the current
# module. In this case, it returns the path to the directory containing the current module.
resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "${path.module}/kubeconfig"
  file_permission = "0400"
}

data "local_file" "kubeconfig_data" {
  depends_on = [local_file.kubeconfig]
  filename = "${path.module}/kubeconfig"
}

output "kubeconfig_path" {
  value       = local_file.kubeconfig.filename
  description = "The path to the kubeconfig file"
}

output "kubeconfig_content" {
  description = "The content of the kubeconfig file for the created cluster."
  value       = data.local_file.kubeconfig_data.content
  sensitive   = true
}