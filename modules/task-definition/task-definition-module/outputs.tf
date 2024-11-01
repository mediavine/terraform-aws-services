output "task_arn" {
    value = aws_ecs_task_definition.this.arn
}
#ARN of the Task Definition with the trailing revision removed.
output "arn_with_revision"{
    value = aws_ecs_task_definition.this.revision
}
#Revision of the task in a particular family
output "arn_without_revision"{
    value = aws_ecs_task_definition.this.arn_without_revision
}