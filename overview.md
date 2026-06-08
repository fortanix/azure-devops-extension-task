# About Fortanix

[Fortanix](https://www.fortanix.com) is a data-first security company helping enterprises discover, assess, and remediate data exposure risks across hybrid multicloud environments.
Fortanix offers an Azure DevOps custom extension task to retrieve the secrets.

## About Fortanix Secret Management task
This extension helps at runtime of Azure DevOps pipeline execution to securely fetch the secrets from Fortanix DSM.

## Usage

### Fortanix DSM

1. Log in to Fortanix DSM at <Your_DSM_Service_URL>. For example, https://amer.smartkey.io.
2. Create or select an account.
2. Create a group.
3. Create an application(app) of type API key in the group.
4. Create a security object of type Secret and upload the secret.
5. Ensure to enable the EXPORT permission for the security object.
6. For more information, refer to [Fortanix-DSM-with-azure-devops](https://support.fortanix.com/docs/fortanix-dsm-with-azure-devops).

### Azure DevOps pipeline

1. Create a pipeline.
2. Export FORTANIX_API_ENDPOINT, eg: amer.smartkey.io.
3. Export FORTANIX_API_KEY as a secret.
4. Configure the task:
      ```
      - task: Fortanix-Secret-Management@1
        inputs:
          FORTANIX_API_ENDPOINT: '$(FORTANIX_API_ENDPOINT)'
          FORTANIX_API_KEY: '$(FORTANIX_API_KEY)'
          FORTANIX_SECURITY_OBJECT_NAME: '<SECURITY_OBJECT_NAME>'
          FORTANIX_SECURITY_OBJECT: 'FORTANIX_SECURITY_OBJECT'
         ```
