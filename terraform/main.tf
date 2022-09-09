# MySQL RDS INSTANCE
resource "aws_db_instance" "plsg_recruitment_db" {
  allocated_storage          = 30
  auto_minor_version_upgrade = true
  backup_retention_period    = 7


  copy_tags_to_snapshot                 = true
  customer_owned_ip_enabled             = false
  db_name                               = "recruitmentdb"
  db_subnet_group_name                  = "default-vpc-3cb60655"
  delete_automated_backups              = true
  deletion_protection                   = false
  enabled_cloudwatch_logs_exports       = []
  engine                                = "mysql"
  engine_version                        = "8.0.28"
  iam_database_authentication_enabled   = false
  identifier                            = "recruitment-1"
  instance_class                        = "db.t3.micro"
  iops                                  = 0
  license_model                         = "general-public-license"
  max_allocated_storage                 = 1000
  monitoring_interval                   = 0
  multi_az                              = false
  option_group_name                     = "default:mysql-8-0"
  parameter_group_name                  = "default.mysql8.0"
  performance_insights_enabled          = false
  performance_insights_retention_period = 0
  port                                  = 3306
  publicly_accessible                   = true
  security_group_names                  = []
  skip_final_snapshot                   = true
  storage_encrypted                     = false
  storage_type                          = "gp2"
  username                              = "recruitment"
  vpc_security_group_ids = [
    "sg-09d8d3049ec72549b",
  ]

  timeouts {}
}

# ELASTIC BEANSTALK APPLICATION
resource "aws_elastic_beanstalk_application" "plsg_recruitment_app" {
  description = "Application created from the EB CLI using \"eb init\""
  name        = "plsg-recruitment"

}

# ELASTIC BEANSTALK ENV
resource "aws_elastic_beanstalk_environment" "plsg_recruitment_env" {
  application            = "plsg-recruitment"
  description            = "Environment created from the EB CLI using \"eb create\""
  name                   = "plsg-recruitment-v4"
  solution_stack_name    = "64bit Amazon Linux 2 v5.5.6 running Node.js 16"
  tier                   = "WebServer"
  version_label          = "app-e697-220909_125624"
  wait_for_ready_timeout = "20m"
}
