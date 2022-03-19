# 2. Data, Variable, Output, Local
This playbook will introduce the usage of data, variable, and output.

## Step to Execute
1. Execute `$ terraform init`
2. If you wish to see the plan, use `$ terraform plan`
3. Execute `$ terraform apply`
4. To destroy, use `$ terraform destroy`

Note: If you wish not to review the plan, add the `-auto-approve` flag when applying/destroying changes.

## Explaination

### 1. Data
As seen on `datas.tf` file:
```
data "google_compute_network" "existing_default_network" {
  name = "default"
}
```
This code block is attempting to retrieve data source information of an existing network in vpc which has the name of `default`. To see how this is being used, take a look at `main.tf` code where it registers new subnetwork to the vpc by specifying:
```
resource "google_compute_subnetwork" "subnetwork" {
  ...

  network       = data.google_compute_network.existing_default_network.id
  ...
}
```

### 2. Variable
As seen on `variables.tf` file:
```
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
```
It declares two variables `region` and `project_id`.  
1. `description` is used to describe the purpose of the declared variable
2. `type` is to specify which data type the variable is (optional)
3. `default` is to specify the default value of the variable (optional)

By default, `$ terraform apply` will use variable from `terraform.tfvars` file, and if it's not found it will try to use the default value. If the default value is not specified, Terraform will prompt for what value should be assigned to the variable (in CLI).  
In some cases in where you want to use custom variable file name, use:
```
$ terraform apply -var-file=another_variable.tfvars
```
Or when you want to pass variable directly from CLI, use:
```
$ terraform apply -var="project_id=enrico-labs"
```
For security purposes Terraform also supports variable read from system environment by declaring the variable with prefix `TF_VAR`, for example:
```
$ export TF_VAR_postgresql_username=postgresql-user
$ export TF_VAR_postgresql_password=postgresql-password
```

### 3. Output
To get outputs, we can simply declare it as the following code block (in `outputs.tf`):
```
output "db_instance_name" {
  value = google_sql_database_instance.db_postgresql_1.name
}
```
In this case, it will produce the following output after every `apply` command is done:
```
db_instance_name = "postgresql-instance"
```

### 4. Local
By using local variables it allows you to store value of expression to be reused but does not allow for passing in values, e.g:
```
locals {
  db_instance_spec = "db-f1-micro"
}
```