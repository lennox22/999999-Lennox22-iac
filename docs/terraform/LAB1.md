# Lab #1

Configuring Your Module
------

Navigate to your training kit folder workshop_materials/terraform/example-module  

Open the main.tf file and populate the file with the contents below. (If your file is not empty, wipe it and paste in the config below)
 
https://git.rockfin.com/training-iac/training-starter-kit/blob/master/workshop_materials/terraform/example-module/main.tf

```hcl
provider "aws" {
  region     = var.aws_region
}

resource "aws_instance" "example" {
  ami                         = "ami-0cd3dfa4e37921605"
  instance_type               = var.instance_type
  associate_public_ip_address = false
  key_name                    = "tf-training"
  subnet_id                   = "subnet-046134d61fe120cbc"

  tags = {
    Name = "${var.application_name}-ec2"
  }
}
```  

Next we'll establish the variables being used in the main.tf.  The required variables to be populated in the variables.tf are below:  

Open the variables.tf file and establish the variables.  

The variable definition format is: **variable "variable_name" {}**  
example:   

```hcl
variable "aws_region" {}  
variable "application_name" {}
variable "instance_type" {}
```

Again, we are simply establishing the variables here, not setting values for them.  We will be populating the variables with a terraform.tfvars file which allows you to pass variables to a terraform module or configuration, without modifying the code itself.  

Now we need to define the variables in a variable input file: terraform.tfvars  

Open the terraform.tfvars file and set the variable values.  

This format is simple. **variable = "variable_value"**
example:     

```hcl
aws_region       = "us-east-2"
application_name = "YOURNAME"
instance_type    = "t3.micro"
```

**Make sure you replace YOURNAME**

Deploying Your Infrastructure
------

Once you have the module configured, it is time to deploy the infrastructure you've defined.  

We must first ensure we have the correct AWS credentials set.

These are the same we used in the AWS class to push our Docker image.  If you still have this as your default credential, no changes are needed here.

There are a couple ways to configure credentials for Terraform.  You can configure the AWS CLI default credentials, use environment variables, specify them in the provider block either explicitly or with a aws cli profile reference.

For our class we'll configure the default credentials:

### AWS Configure

```
aws configure
AWS Access Key ID [None]: $FROM_LINK_ABOVE
AWS Secret Access Key [None]: $FROM_LINK_ABOVE
Default region name [None]: us-east-2
Default output format [None]: hit enter
```

Deploy Module
------

Once configured, in the example-module directory, run the following commands:    

```
terraform init 
```

Take note of the output.  This initializes the working directory for terraform use.  If initialize is clean, proceed.  

```
terraform plan 
```

Take note of the output.  This details what resources and configurations will be deployed.  If something doesn’t look right, correct it in the main.tf and run the plan again.  Once the plan looks good, proceed.  

```
terraform apply  
```

Once again, take note of the output to ensure it matches the plan command and enter “yes” to deploy the infrastructure.   
After you've verified the instance is up with your desired configuration, come back to the terraform.tfvars file and change the instance type from t3.micro to t3.small.  Run through the plan and apply steps again to deploy the configuration change.  
  

Destroying Your Infrastructure
------

The last step is to clean up our infrastructure once we've verified it deploys correctly.  
  
To destroy the infrastructure, from the Terraform configuration root directory, run:
  
```
terraform destroy
```  
  
Like the apply command, the destroy will output each resource it is going to destroy and prompt for confirmation before doing so.  If everything looks as expected, enter YES and destroy the infrastructure. 
