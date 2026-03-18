### Description

Azure DevOps is an end-to-end software development platform that offers an assortment of capabilities intended 
to organize and accelerate development efforts across the entire application lifecycle.
To keep the secrets secured in an Azure DevOps pipeline, a Secret Management is required. 

### Solution

Leverage Fortanix DSM to securely retrieve the secrets at runtime of Azure DevOps pipeline execution.
Fortanix offers an ADO custom extension Task to retrieve the secrets.

#### How to build a custom extension in Azure DevOps that fetches the secrets?

1. Install Node js(Latest version is preferred)
2. Build the extension
   * Install tfx-cli, command: npm install -g tfx-cli
   * Configure manifest.env
   * Run ./build.sh
        * This will create the files below:
           * Fortanix-Secret-Management/task.json
           * Fortanix-Secret-Management/package.json
           * Fortanix-Secret-Management/node_modules
           * vss-extension.json
3. Find the extension in the same directory as <PUBLISHER_ID>.<EXTENSION_NAME>-<VERSION>.vslx
   * eg: Fortanix-ADO.Secret-Management-1.0.0.vslx

#### manifest.env Attributes

1. MANIFEST_VERSION: Version of manifest
2. ID: Unique Identifier(UUID), e.g., d9f8b8c2-1b48-4e5c-b0f5-41f2e7cf88a5
3. EXTENSION_NAME: Name of the extension that is presented while installing this extension
4. PUBLISHER_ID: ID of the Azure DevOps publisher 
5. TASK_NAME: Name of the task that is presented in the Azure pipelines
6. VERSION: Version of the extension
7. AUTHOR: Name of the Author

#### How to execute the extension

1. Upload the extension to ADO marketplace
   * https://marketplace.visualstudio.com/manage/publishers/<PUBLISHER_ID>
2. Share it to the ADO organization
3. Go to the ADO organization -> Oraganization Settings -> Extensions -> Shared -> Install
4. Create a new project in ADO organization and provide access to any github repository
5. Create a new pipeline
6. Configure FORTANIX_API_KEY as a secret in Variables
7. Go to show assistant and search for Fortanix-Secret-Management
8. Configure all the listed paramaters:
   * FORTANIX_API_ENDPOINT, eg: apac.smartkey.io 
   * FORTANIX_API_KEY, eg: $(FORTANIX_API_KEY)
   * FORTANIX_SECRET, name of a Security Object(SECRET)
   * SECRET_VARIABLE_NAME, variable to save the secret value
9. This will fetch the secret

#### Pre-requisites

1. To build the extension, Node.js v20 or above is required
2. FORTANIX DSM Account
   a. Configure Group, App API key and Security Object(SECRET)
   b. Ensure to enable the EXPORT permission for Security Object(SECRET)
3. Azure DevOps Organization
   a. Configure Publisher, Project, Github repository 


