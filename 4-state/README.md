# 4. State
The Terraform state is used to map real world resources with your configuration, keep track of meta data, and to improve performance for large infrastructures. To learn more about the purpose, read [here](https://www.terraform.io/language/state/purpose). It is stored locally in `terraform.tfstate` file, and can also be stored remotely which will help you if you're working in a team. Imagine when you and your friend update the infrastructure at the same time, it may lead to race conditions as multiple Terraform processes make concurrent updates and causing conflicts, data loss, and state file corruption. Therefore it's recommended to store the Terraform state remotely so that there'll be locking mechanism when someone is updating the resources.  

One way of saving the state is by storing it to GCS/S3 bucket, which shouldn't cost much as it's relatively only a small JSON file.

## Step to Execute
1. Execute `$ terraform init`
2. If you wish to see the plan, use `$ terraform plan`
3. Execute `$ terraform apply`
4. To destroy, use `$ terraform destroy`

Note: If you wish not to review the plan, add the `-auto-approve` flag when applying/destroying changes.

## Explanation
In this playbook, if you try to run `$ terraform init` it will not generate a `terraform.tfstate` file locally, since it will be stored to GCS. Don't forget that you'll need to create the bucket for it and it's recommended to enable object versioning in case any unexpected things happen.  

To verify your lock is working, you can try to run the `$ terraform apply` concurrently, and it will shows you the following error:
```
│ Error: Error acquiring the state lock
│ 
│ Error message: writing "gs://tf-state-testing-123123/terraform/state/default.tflock" failed: googleapi: Error 412: At least one of the
│ pre-conditions you specified did not hold., conditionNotMet
│ Lock Info:
│   ID:        1647763413250412
│   Path:      gs://tf-state-testing-123123/terraform/state/default.tflock
│   Operation: OperationTypeApply
│   Who:       local.machine
│   Version:   1.1.5
│   Created:   2022-03-20 08:03:33.193127 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
```