# azure-logic-app-standard-with-private-endpoint-and-private-storage-account

terraform workspace new dev 
terraform workspace select dev
terraform init -var-file="dev.tfvars" 
terraform plan -var-file="dev.tfvars" 
terraform apply -var-file="dev.tfvars"  --auto-approve

terraform workspace new prod 
terraform workspace select prod
terraform init -var-file="prod.tfvars" 

terraform plan -var-file="prod.tfvars" 

terraform apply -var-file="prod.tfvars"  --auto-approve
