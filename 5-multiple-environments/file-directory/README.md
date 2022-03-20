# File Directory
As seen in this directory file structure:
```
.
├── modules
│   └── networking
│       ├── main.tf
│       └── variables.tf
├── production
│   ├── main.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── staging
    ├── main.tf
    ├── terraform.tfvars
    └── variables.tf
```
Furthermore, when having the same resource across all environments you can introduce global/shared directory.  
At some point it it may cause a hassle to make changes, therefore in order to reduce complexity of changing directory and executing changes one by one, the workaround is to create a script to automate those things.

## Step to Execute
1. Change directory to production/staging `$ cd {production/staging}`
2. Execute `$ terraform init`
3. If you wish to see the plan, use `$ terraform plan`
4. Execute `$ terraform apply`
5. To destroy, use `$ terraform destroy`

Note: If you wish not to review the plan, add the `-auto-approve` flag when applying/destroying changes.
