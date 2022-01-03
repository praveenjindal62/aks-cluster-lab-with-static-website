$tfstate_storage_account_name = "terraformstatepjepam"
$tfstate_container_name = "terraformstate"
$tfstate_key_name = "aks-cluster-static-web-lab/terraform.tfstate"
$access_key=$(az storage account keys list -n $tfstate_storage_account_name --query [0].value -o tsv)
terraform init -backend-config="storage_account_name=$tfstate_storage_account_name" -backend-config="container_name=$tfstate_container_name" -backend-config="access_key=$access_key" -backend-config="key=$tfstate_key_name"