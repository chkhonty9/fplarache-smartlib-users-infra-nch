provider "aws" {
    region = var.aws_region
}

resource "aws_ecr_repository" "app_repo" {
    name = var.ecr_repository_name
    image_tag_mutability = "MUTABLE"
}

resource "aws_ecs_cluster" "app_cluster" {
    name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "app_task" {
    family                = var.ecs_task_family
    container_definitions = <<DEFINITION
    [
        {
            "name": "dev-smartlib-users-container",
            "image": "${aws_ecr_repository.app_repo.repository_url}:latest",
            "essential": true,
            "memory": 512,
            "cpu": 256 
        }
    ]
    DEFINITION
    requires_compatibilities = [ "FARGATE" ]
    network_mode = "awsvpc"
    memory = "512"
    cpu = "256"
    #execution_role_arn = aws_iam_role.ecs_task_execution.arn
    execution_role_arn = "arn:aws:iam::774305596814:role/ecsTaskExecutionRole"
}

resource "aws_ecs_service" "app_service" {
  name = var.ecs_service_name
  cluster = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type = "FARGATE"
  network_configuration {
    subnets = var.subnet_ids
    assign_public_ip = true
    security_groups = var.groups_security_ids
  }

  desired_count = 1

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "dev-smartlib-users-container"
    container_port   = 80  
  }

  health_check_grace_period_seconds = 5
  
  enable_ecs_managed_tags = true
  depends_on = [aws_lb_target_group.app_target_group]
}

# resource "aws_iam_role" "ecs_task_execution" {  
#   name = "ecsTaskExecutionRole"  

#   assume_role_policy = jsonencode({  
#     Version = "2012-10-17"  
#     Statement = [  
#       {  
#         Effect = "Allow"  
#         Principal = {  
#           Service = "ecs-tasks.amazonaws.com"  
#         }  
#         Action = "sts:AssumeRole"  
#       }  
#     ]  
#   })  
# }  

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {  
#   role       = aws_iam_role.ecs_task_execution.name  
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"  
# }
