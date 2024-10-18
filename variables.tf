variable "project" {
  description = "Project Name"
  default     = "accounting_system"
}

variable "environment" {
  description = "Environment to release"
  default     = "dev"
}

variable "location" {
  description = "Resource cloud location"
  default     = "East US 2"
}

variable "sql_server_password" {
  description = "MSSQL Server admin password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags assigned to project resources"
  default = {
    "environment" = "dev"
    "project"     = "accounting_system"
    "created_by"  = "terraform"
  }
}
