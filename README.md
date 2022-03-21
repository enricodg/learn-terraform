# Learn Terraform

[Terraform](https://www.terraform.io/) is an open-source [IaaS](https://azure.microsoft.com/en-us/overview/what-is-iaas/) (Infrastructure as a Service) software developed by HashiCorp. Same with other IaaS software, Terraform is used to manage and provision cloud infrastructure, network appliances, SaaS, and PaaS.  

The special thing about Terraform is that it provides declarative configuration language rather than imperative instructions. Real life example of declarative vs imperative instruction is when you're trying to get an air conditioner cleaned. In **declarative** way you would say **"Please clean my AC"** and you don't care what procedure is needed to clean the AC. Meanwhile in **imperative** way you will need to **instruct** the cleaner to open the AC, unplug it from electricity, etc.  

So in Terraform, you only need to declare the final state of your infrastructure without worrying how it would be done, the tool will find a way to reach the desired state.  

To manage the resources, HashiCorp maintains a humongous amount of providers to choose from, and community-developed providers which can be found in the  [registry](https://registry.terraform.io/).

## Installation

Visit Terraform [download page](https://www.terraform.io/downloads), or install it via [brew](https://brew.sh/) with the following command:
```
$ brew tap hashicorp/tap
$ brew install hashicorp/tap/terraform
```

## Main Commands

Terraform has 5 major commands:
| Command | Description |
|---------|-------------|
| init    | Prepare your working directory for other commands |
| validate| Check whether the configuration is valid |
| plan    | Show changes required by the current configuration |
| apply   | Create or update infrastructure (use `-auto-approve` flag to auto apply without the need of reviewing plan)|
| destroy | Destroy previously-created infrastructure (use `-auto-approve` flag to auto apply without the need of reviewing plan) |

Find out more about commands [here](https://www.terraform.io/cli/commands).

## Data Types

Supported data types:
- `string` : `"hello"`
- `number` : `1.23`
- `bool` : `true`
- `list` or `tuple` : `["us-west-1a", "us-west-1c"]`
- `map` or `object` : `{name = "Mabel", age = 52}`

Find more about data types [here](https://www.terraform.io/language/expressions/types).

## Syntax
Terraform files are written in HashiCorp Configuration Language (HCL) format which relatively easy for humans to read and write. To learn more please visit [this page](https://www.terraform.io/language/syntax).  

Format:
```
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```
Example:
```
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}
```

Here are some commonly used block types:
| Block Type | Description |
|------------|-------------|
| resource   | Describes one or more infrastructure objects, such as virtual networks, compute instances, or higher-level components such as DNS records |
| data       | Allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions |
| provider   | Allow Terraform to interact with cloud providers, SaaS providers, and other APIs |
| variable   | To customize aspects of Terraform modules without altering the module's own source code |
| output     | Give information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use |
| locals     | Assigns a name to an expression, so you can use it multiple times within a module without repeating it |
| module     | Containers for multiple resources that are used together |

Code expressions can be found [here](https://www.terraform.io/language/expressions).  
Terraform has built-in functions which can be found [here](https://www.terraform.io/language/functions).

## Playbook

The following playbook will require access to GCP console. Please get your [service account](https://console.cloud.google.com/iam-admin/serviceaccounts) key and set to your local environment using:
```
export GOOGLE_CREDENTIALS=`cat ~/path/to/your/key.json`  
```

### 1. [Getting Started](1-getting-started)  
Contains basic explanation of basic terraform structure, provider, and resource.
### 2. [Data, Variable, Output, Local](2-data-variable-output-local)
Introducing data, variable (input), output, and local use case.
### 3. [Consume & Create Module](3-consume-and-create-module)
Demonstrates how to consume widely available module, and create module to make it reusable.
### 4. [State](4-state)
Shows how state is very useful when you're working in a team.
### 5. [Multiple Environments](5-multiple-environments)
Methods of managing multiple environments using Terraform.
### 6. [Provisioning GCP GKE](6-provisioning-gcp-gke)
Demonstrate how to provision Kubernetes cluster on GCP using GKE
### 7. [Provisioning AWS EKS](7-provisioning-aws-eks)
Demonstrate how to provision Kubernetes cluster on AWS using EKS
