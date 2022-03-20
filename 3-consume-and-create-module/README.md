# 3. Consume and Create Module
This playbook will show the usage of `module` that has the purpose of reusability and modularity. Terraform has provided a bunch of publicly available modules which you can find [here](https://registry.terraform.io/browse/modules), moreover you can create your own module and host it in a private module registry.

## Step to Execute
1. Change directory to app `$ cd app`
2. Execute `$ terraform init`
3. If you wish to see the plan, use `$ terraform plan`
4. Execute `$ terraform apply`
5. To destroy, use `$ terraform destroy`

Note: If you wish not to review the plan, add the `-auto-approve` flag when applying/destroying changes.

## Explanation
[app](app) directory is the root module consisting of two child modules ([1 VM instance with NGINX](modules/my-app), and [1 postgresql database instance](modules/google-cloud-sql)). 
### 1. Root Module
As seen on [app/main.tf](app/main.tf):
```
module "my_app_1" {
  source = "../modules/my-app"

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  labels     = var.labels
}

module "my_db_1" {
  source = "../modules/google-cloud-sql"

  database_user          = var.database_user
  database_instance_name = var.database_instance_name
  region                 = var.region
  zone                   = var.zone
  project_id             = var.project_id
}
```
The code block above shows how the main Terraform application consumes two modules that has been declared in [modules](modules) directory. The only required attribute (identifier) for locally created module is only `source`, while the others depend on the child module requirement.

### 2. Child Module
#### Consuming public module
The [modules/google-cloud-sql/main.tf](modules/google-cloud-sql/main.tf) is where we consume the module that's already provided by Google (read more [here](https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest/submodules/postgresql)). Everything declared in [modules/google-cloud-sql/variables.tf](modules/google-cloud-sql/variables.tf) will be the attribute (identifier) when it's called by another module.
```
module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "10.0.0"

  name                = var.database_instance_name
  project_id          = var.project_id
  region              = var.region
  zone                = var.zone
  database_version    = "POSTGRES_11"
  user_name           = var.database_user
  db_name             = var.database_name
  deletion_protection = false # testing purposes only
}
```
The only required attributes (identifier) to consume public module is `source` and `version`, while the others will require you to read their documentation.

#### Create your own module
The [modules/my-app](modules/my-app) is an example of a module. Basically you just need to provide a directory consisting of  Terraform code. Everything declared in [modules/my-app/variables.tf](modules/my-app/variables.tf) will be the attribute (identifier) when it's called by another module.

### 3. Output
Since password is a sensitive information, therefore we will need to set `sensitive = true` in [output.tf](app/outputs.tf) so whenever we perform `$ terraform apply` it will be hidden. In order to see the password, you can directly run command from the CLI using:
```
$ terraform output database_password
```