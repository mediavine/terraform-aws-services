output "task_arn" {
    value = aws_ecs_task_definition.this.arn
}

output "task_without_arn" {
    value = aws_ecs_task_definition.this.arn_without_revision
}

output "task_revision" {
    value = aws_ecs_task_definition.this.revision
}

output "container_definition" {
    value = aws_ecs_task_definition.this.container_definitions
}