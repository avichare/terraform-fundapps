This repo consists of terraform code which creates autoscaling group with ELB and other necessary resources (like Security Group, S3 bucket, CloudWatch alarms, IAM role and policy, etc.). This code installs nginx on EC2 instances which are part of ASG.

Pre-requisites to run this code:
--------------------------------
1) Terraform binaries available and set in PATH.

2) By following https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html, AWS access key and secret key and region should be set to create .aws/config profile on local machine.

3) The user who's access key and secret keys are used has permission to create these resources in AWS account.

Assumptions:
------------
1) Resources to be created in AWS account's default VPC.

2) Terraform state files are created locally when the code is executed.

Steps to create resources:
-------------------------
1) Clone the Git repo to local PATH
2) cd to the root of cloned repo
3) Run 'terraform init' (To initialise terraform binaries and compile the code)
4) Run 'terraform plan' (To double-check what resources would be created)
5) Run 'terraform apply' (To trigger creation of those resources)
