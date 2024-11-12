output "container_definitions" {
  description = "container definition to pass to ecs service"
  value       = local.container_definition
}

output "sidecar_definitions" {
  description = "sidecar definition to pass to ecs service"
  value       = local.sidecar_definition
}
