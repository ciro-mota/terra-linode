<h2>Terra Linode</h2>

<p align="center">
    <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge" />
    <img alt="Linode" src="https://img.shields.io/badge/Linode-00A95C?style=for-the-badge&logo=Linode&logoColor=white" />
    <img alt="Terraform" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
    <img alt="Red Hat" src="https://img.shields.io/badge/Red%20Hat-EE0000?style=for-the-badge&logo=redhat&logoColor=white" />
    <img alt="Debian" src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white" />
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
    <img alt="Alpine" src="https://img.shields.io/badge/Alpine_Linux-0D597F?style=for-the-badge&logo=alpine-linux&logoColor=white" />
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" />
    <img alt="Last Commit" src="https://img.shields.io/github/last-commit/ciro-mota/terra-linode?style=for-the-badge" />
</p>


This project aims to provision instances on Linode with the help of Terraform.

## 🎁 Sponsoring

If you like this work, give me it a star on GitHub, and consider supporting it buying me a coffee:

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?business=VUS6R8TX53NTS&no_recurring=0&currency_code=USD)

## ⚠️ Caution!

Linode charges you for the use of VMs [even if they are in a powered off state](https://www.linode.com/docs/products/platform/billing/#will-i-be-billed-for-powered-off-or-unused-services) and this can cause a huge cost issue for some people. So you can never forget to `destroy` your instances after some testing.

## 📌 Before executing:

1. It is necessary to get credentials for Terraform execution.

- Create a [Linode Personal Access Token](https://www.linode.com/docs/products/tools/api/guides/manage-api-tokens/).

2. Add two variables to your `.bashrc` or `.zshrc` file:

```bash 
export TF_VAR_LINODE_CLI_TOKEN=<your-personal-access-token>
export TF_VAR_public_key_path=$(cat /home/your-username/.ssh/id_rsa.pub)
```

## 💻 Usage

- Clone this repo.
- By default an instance with **Debian 12** with `g6-nanode-1` will be provisioned, if you want another OS or machine, modify the `variables.tf` files if you wish.
- Run `terraform init`, `terraform plan -out= name-of-the-plan` and `terraform apply`. At the end, `terraform destroy`

## 🔧 Stackscripts

You can also apply post-installation scripts to your Linode instance through Stackscripts. This project counts as example scripts for `nginx` provisioning.

You can create your own script and send it into the instance via the `bash <(curl -sk URL)` line in the `resources.tf` file.

To work with these settings, uncomment line `10` in the `instance.tf` file.

## 💾 Remote state

Linode clearly does not have an official backend for remote state so adaptation is necessary to work with this feature.

- You will need to have `linode-cli` and the `boto3` library installed.
- In the `resources.tf` file, uncomment lines `45` to `52`.
- On line `49` change the `cluster` and bucket name to the ones you created.

Terraform will, after provisioning the requested resources, run `linode-cli` to send the `terraform.tfstate` file to a previously created bucket.