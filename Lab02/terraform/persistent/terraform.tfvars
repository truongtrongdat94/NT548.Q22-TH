region       = "ap-southeast-1"
project_name = "eventfund"
environment  = "dev"

# VPC
vpc_cidr             = "10.0.0.0/16"
public_subnets_cidr  = ["10.0.0.0/20", "10.0.16.0/20"]
private_subnets_cidr = ["10.0.128.0/20", "10.0.144.0/20"]
azs                  = ["ap-southeast-1a", "ap-southeast-1b"]

# ECR
ecr_backend_repo = "eventfund-backend"

# GitHub Actions
github_actions_role_name = "GitHubActionsRole"
github_repos             = ["repo:kieuphat159/Eventfund-platform:*"]

# S3 Security Reports
security_reports_bucket         = "eventfund-security-reports"
security_reports_retention_days = 15
