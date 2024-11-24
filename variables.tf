variable "aws_region" {  
  default = "eu-north-1"  
}  

variable "ecr_repository_name" {  
  default = "dev-fplarache-smartlib-users-nch-repo"  
}  

variable "ecs_cluster_name" {  
  default = "dev-fplarache-smartlib-users-fgcluster-nch"  
}  

variable "ecs_task_family" {  
  default = "dev-fplarache-smartlib-users-td-nch"  
}  

variable "ecs_service_name" {  
  default = "dev-fplarache-smartlib-users-service-nch"  
}  

variable "subnet_ids" {  
  type = list(string)  
}

variable "target_group_arn" {
  type = string
}

variable "groups_security_ids" {  
  type = list(string)  
}