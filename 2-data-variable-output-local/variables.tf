variable "region" { # region is the variable name
  description = "choosen region data"
  default     = "asia-southeast2"
}

variable "project_id" { # project_id is the variable name
  description = "project id from gcp"
  type        = string
}

variable "postgresql_username" { # postgresql_username is the variable name, specified in environment
  description = "database username"
  type        = string
}

variable "postgresql_password" { # postgresql_password is the variable name, specified in environment
  description = "database password"
  type        = string
}