# About Fortanix

[Fortanix](https://www.fortanix.com) is a data-first security company helping enterprises discover, assess, and remediate data exposure risks across hybrid multicloud environments.
Fortanix offers an Azure DevOps custom extension task to retrieve the secrets.

## About Fortanix Secret Management task
This extension helps at runtime of Azure DevOps pipeline execution to securely fetch the secrets from Fortanix DSM.

## Usage

### Fortanix DSM

1. Login to Fortanix DSM, eg: amer.smartkey.io
2. Create a Group
3. Create an App of type API key in the group
4. Create a Security Object of type Secret and upload the secret
5. Ensure to enable the EXPORT permission for Security Object
6. For more information [DSM-key-lifecycle-management](https://support.fortanix.com/docs/users-guide-fortanix-data-security-manager-key-lifecycle-management)

### Azure DevOps pipeline

1. Create a pipeline
2. export FORTANIX_API_ENDPOINT, eg: amer.smartkey.io
3. export FORTANIX_API_KEY as a secret
4. Configure the task:
      ```
      - task: Fortanix-Secret-Management@1
        inputs:
          FORTANIX_API_ENDPOINT: '$(FORTANIX_API_ENDPOINT)'
          FORTANIX_API_KEY: '$(FORTANIX_API_KEY)'
          FORTANIX_SECURITY_OBJECT_NAME: '<SECURITY_OBJECT_NAME>'
          FORTANIX_SECURITY_OBJECT: 'FORTANIX_SECURITY_OBJECT'
         ```
