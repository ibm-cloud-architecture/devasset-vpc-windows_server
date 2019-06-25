# Deploy Windows server on IBM Cloud Virtual Private Network

This asset provides the scripts to provision a single zone VPC with access to the internet. Then deploy a Windows virtual service instance into the VPC using Terraform.

![Architecture](imgs/architecture.png)

### Prerequisites

1. Active IBM Cloud account with credentials for an IBMid or ServiceID that can deploy [VPC infrastructure](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-getting-started).
2. Access to a public SSH key.
3. Obtain the variables in the [variables.tf](./infrastructure_code/variables.tf) file required to deploy this pattern.

   - Add values for iaasapikey, paasapikey, iaasusername for authorization.
   - Add desired ibm_region, availability_zone and riaas_endpoint endpoint in variable.tf files.
   - Add ssh_key value which will be required while creating VSI.

### Steps to Deploy pattern

1. **Build** Docker to run terraform VPC ibm provider

   - docker build -t="terraform-vpc-ibm-docker" . --no-cache
   - docker run -it terraform-vpc-ibm-docker /bin/bash

2. **Run** Terraform script:

   - cd infrastructure-code
   - terraform init
   - terraform plan
   - terraform apply

3. **Test** by connecting to the instance using Remote Desktop protocol using the floating IP as target. To properly connect,

   - Get encrypted password from UI and saved to a file, decode it using:
     ```
     cat UI_PASSWORD_FILE | base64 --decode > decoded_base64_password_file
     ```
   - Decrypt it using the SSH key used to create the instance:
     ```
     openssl pkeyutl -in decoded_base64_password_file -decrypt -inkey ~/.ssh/id_rsa -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256 > finalpass
     ```
     ```
     cat finalpass
     ```

### Notes:

- New VPC will be assigned to new resource group `vpc_test` created in given region (ibm_region from variable.tf).
- You need Administrator access to the given resource_group, in order to view encrypted password on VSI.

  <!-- - New VPC resources will be assigned the account's default Resource Group. Use the ibmcloud target command to select the desired group and region for the VPC. In our case we want to use group VPC1 instead of default, and locate the VPC in the us-south region. -->

<!-- - Edit the variables.tf file to enter your particular values for each deployment -->
