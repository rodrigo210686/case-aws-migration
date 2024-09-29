resource "aws_ecs_cluster" "prd_cluster" {
  name = "app-cluster"
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.prd_cluster.id
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.prd_cluster.arn
}
