# aks-lab
This repository deploys a dev/test AKS cluster.

# Pre-requisites
1. Configure an app registration and federated workload identity in Azure - https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation
2. Grant the identity "Contributor" access on the target subscription.
3. Create the following variables in GitHub:
  - ARM_CLIENT_ID - The app ID of the app registration for GitHub Actions
  - ARM_TENANT_ID - The target Entra Tenant's ID
  - ARM_SUBSCRIPTION_ID - The target subscription ID
  - tf_state_storage_account_name - The name of the storage account to hold TF state
  - tf_state_storage_account_container_name - The name of the storage container to hold the TF state
4. Create a storage account and container to host TF state.
5. Grant the workload identity the 'Storage Blob Data Owner' role on the storage account.