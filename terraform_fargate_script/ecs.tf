resource "aws_ecs_cluster" "ecs" {
  name = "app_cluster"
}

resource "aws_ecs_service" "service1" {
  name                   = "app_service1"
  cluster                = aws_ecs_cluster.ecs.arn
  launch_type            = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  task_definition                    = aws_ecs_task_definition.td1.arn

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.sg.id]
    subnets          = [aws_subnet.sn1.id, aws_subnet.sn2.id, aws_subnet.sn3.id]
  }
}

resource "aws_ecs_task_definition" "td1" {
  family                   = "app11"
  requires_compatibilities = ["FARGATE"]

  cpu                = "512"
  memory             = "1024"
  network_mode       = "awsvpc"
  task_role_arn      = "arn:aws:iam::416007387859:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::416007387859:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "app11"
      image     = "satulakhil/frontend:React"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service2" {
  name                   = "app_service2"
  cluster                = aws_ecs_cluster.ecs.arn
  launch_type            = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  task_definition                    = aws_ecs_task_definition.td2.arn

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.sg.id]
    subnets          = [aws_subnet.sn1.id, aws_subnet.sn2.id, aws_subnet.sn3.id]
  }
}

resource "aws_ecs_task_definition" "td2" {
  family                   = "app12"
  requires_compatibilities = ["FARGATE"]

  cpu                = "512"
  memory             = "1024"
  network_mode       = "awsvpc"
  task_role_arn      = "arn:aws:iam::416007387859:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::416007387859:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "app12"
      image     = "satulakhil/backend:java"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}
