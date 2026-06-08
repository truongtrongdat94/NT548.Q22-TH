region       = "ap-southeast-1"
project_name = "eventfund"
environment  = "dev"

# EKS
eks_version               = "1.33"
node_group_instance_types = ["m7i-flex.large"]
node_desired_capacity     = 2
node_min_capacity         = 1
node_max_capacity         = 4
node_capacity_type        = "SPOT"
node_ami_type             = "AL2023_x86_64_STANDARD"
node_disk_size            = 20
node_max_unavailable      = 1
node_repair_enabled       = true

cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true
cluster_public_access_cidrs     = ["0.0.0.0/0"]
service_ipv4_cidr               = "172.20.0.0/16"
cluster_log_types               = []
authentication_mode             = "API_AND_CONFIG_MAP"
bootstrap_admin_permissions     = true

# Admin users for local development
admin_user_arns = []

# SSM
ssm_prefix = "/eventfund/dev/backend"
