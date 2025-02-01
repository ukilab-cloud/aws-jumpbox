# AWS Jumpbox Introduction
An Ubuntu instance with all the tools/permissions to perform Terraform deployments.
Primarily for use in lab environments. Please review the userdata-linux.tpl and IAM roles before deployment.

# Purpose

This environment is designed as basis for terraform based labs such as:

- [Fortinet FGCP Active/Passive HA Lab](https://github.com/ukilab-cloud/lab-tgw-fgcp) which is documented [here](https://ukilab-cloud.github.io/lab-tgw-fgcp/)



## Requirements
- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 1.6.0
- An SSH Client.
- An AWS account with EC2, VPC and IAM write permissions.


## Deployment Overview
![Jumpox Architecture](.images/jumpbox-architecture.png?raw=true "Jumpbox Architecture")

### Included in the deployment

 - Ubuntu 24.10 LTS Jumpbox accessible over public IP
     - Terraform 1.6+
     - git
     - micro (terminal editor)
     - neovim (terminal editor)
     - helix (terminal editor)
     - zellij (friendly terminal multiplexer)
     - lsd (ls alternative)
 - Change shell to Fish shell for LabX user
 - AWS IAM Role with STS Assumption applied to Ubuntu host for use by Terraform
 - AWS Console User for viewing lab activities (Password must be set manually)
 - SSH Key Pair for accessing the UbuntuHost

## Deployment
- Clone the repository.
- Copy `terraform.tfvars.example`  to `terraform.tfvars` 
- Change ACCESS_KEY and SECRET_KEY values in terraform.tfvars
- Change parameters in the variables.tf
    - Advise adding your IP to "vpc_jumpbox_allowed_cidr" variable as all access is disabled by default
    - Use myip.com to quickly get your public IP 
    ```sh
    $ ssh sshmyip.com
    ```
- If using SSO, uncomment the token variable in variables.tf and main.tf
* Initialize the providers and modules:
  ```sh
  $ terraform init
  ```
* Submit the Terraform plan:
  ```sh
  $ terraform plan
  ```
* Verify output.
* Confirm and apply the plan:
  ```sh
  $ terraform apply
  ```
* If output is satisfactory, type `yes`.

Output will include the information necessary to log in to the Jumpbox:
```sh
Outputs:

jumpbox_password  = "<Instance ID>"
jumpbox_public_ip = "<public IP of Jumpbox>"
jumpbox_username  = "lab1 (default)"

```
If password login is disabled (recommended outside of lab environments) then use the SSH Key generated and log in as `ubuntu@<Public IP of Jumpbox>`

## Destroy the environment
To destroy the environment, use the command:
```sh
$ terraform destroy
```

# Disclaimer
This is a community project, the of this project are offered "as is". The authors make no representations or warranties of any kind, express or implied, as to the use or operation of content and materials included on this site. To the full extent permissible by applicable law, the authors disclaim all warranties, express or implied, including, but not limited to, implied warranties of merchantability and fitness for a particular purpose. You acknowledge, by your use of the site, that your use of the site is at your sole risk. 

If you break it, it is on you.
