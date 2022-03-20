# 4. Multiple Environments
This playbook will cover two ways of managing multiple environments.
1. [File directory](file-directory)
2. [Terraform workspace](workspace)

| | Pros | Cons |
| - | - | - |
| File directory | - Isolation of backends (better security & less human error)<br/>- Codebase represents deployed state | - Multiple `$ terraform apply` is required to provision environments<br/>- Code duplication |
| Workspace | - Minimum of code duplication (DRY)<br/>- Easy to get started | - Prone to human error<br/>- State is stored within the same backend<br/>- Deployment configuration may be ambiguous (because of workspace) |