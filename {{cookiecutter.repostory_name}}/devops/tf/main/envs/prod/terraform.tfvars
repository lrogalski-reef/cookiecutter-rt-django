# each of this vars can be overriden by adding ENVIRONMENT variable with name:
# TF_VAR_var_name="value"

name             = "{{ cookiecutter.aws_project_name }}-prod"
region           = "{{ cookiecutter.aws_region }}"

# VPC and subnet CIDR settings, change them if you need to pair
# multiple CIDRs (i.e. with different component)
vpc_cidr         = "10.2.0.0/16"
subnet_cidrs     = ["10.2.1.0/24", "10.2.2.0/24"]
azs              = ["{{ cookiecutter.aws_region}}c", "{{ cookiecutter.aws_region}}d"]

# By default, we have an ubuntu image
base_ami_image        = "{{ cookiecutter.aws_ami_image}}"
base_ami_image_owner  = "{{ cookiecutter.aws_ami_image_owner }}"

# domain setting
base_domain_name = "{{ cookiecutter.aws_base_domain_name }}"
domain_name      = "{{ cookiecutter.aws_domain_name }}"

# default ssh key
ec2_ssh_key      = "{{ cookiecutter.aws_ec2_ssh_key }}"

monitoring_cert  = ""
monitoring_key   = ""
monitoring_ca    = ""