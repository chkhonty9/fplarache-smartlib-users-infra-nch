variable "aws_region" {  
  default = "eu-north-1"  
}  

variable "ecr_repository_name" {  
  default = "dev-fplarache-smartlib-users-repo-NCh"  
}  

variable "ecs_cluster_name" {  
  default = "dev-fplarache-smartlib-users-fgcluster-NCh"  
}  

variable "ecs_task_family" {  
  default = "dev-fplarache-smartlib-users-td-NCh"  
}  

variable "ecs_service_name" {  
  default = "dev-fplarache-smartlib-users-service-NCh"  
}  

variable "subnet_ids" {  
  type = list(string)  
}