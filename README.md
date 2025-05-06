# aks-lab
This repository deploys a dev/test AKS cluster.

# Pre-requisites
1. Configure an app registration and federated workload identity in Azure - https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation
2. Grant the identity "Contributor" access on the target subscription.
3. Create the following variables in GitHub:
  - ARM_CLIENT_ID - The app ID of the app registration for GitHub Actions
  - ARM_TENANT_ID - The target Entra Tenant's ID
  - ARM_SUBSCRIPTION_ID - The target subscription ID
4. 