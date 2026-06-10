### Description

Azure DevOps is an end-to-end software development platform that offers an assortment of capabilities intended 
to organize and accelerate development efforts across the entire application lifecycle.
To keep the secrets secured in an Azure DevOps pipeline, a Secret Management is required. 

### Solution

Leverage Fortanix DSM to securely retrieve the secrets at runtime of Azure DevOps pipeline execution.
Fortanix offers an ADO custom extension Task to retrieve the secrets.

#### How to build the Fortanix-Secret-Management extension and upload in the marketplace?

1. Install Node js(Latest version(20 or above) is preferred)
2. Build the extension
   * Configure manifest.env, Add ID and PUBLISHER_ID.
   * Run ./build.sh
3. Find the extension in the same directory as <PUBLISHER_ID>.<EXTENSION_NAME>-<VERSION>.vslx
   * eg: Fortanix-ADO.Fortanix-Secret-Management-1.0.0.vslx
4. Upload the extension
    1. Go to marketplace https://marketplace.visualstudio.com/manage.
    2. Select the organization
    3. Select New extension -> Visual Studio Code
    4. Upload the extension

#### manifest.env Attributes

1. MANIFEST_VERSION: Version of manifest
2. ID: Unique Identifier(UUID), e.g., d9f8b8c2-1b48-4e5c-b0f5-41f2e7cf88a5
3. EXTENSION_NAME: Name of the extension that is presented while installing this extension
4. PUBLISHER_ID: ID of the Azure DevOps publisher 
5. TASK_NAME: Name of the task that is presented in the Azure pipelines
6. VERSION: Version of the extension
7. AUTHOR: Name of the Author

#### How to execute the extension

1. Go to the marketplace
   * https://marketplace.visualstudio.com/items?itemName=Fortanix.Fortanix-Secret-Management
2. Click on "Get it for free", Install it into the ADO organization
3. Create a new project in ADO organization and provide access to any github repository
4. Create a new pipeline
5. Configure FORTANIX_API_KEY as a secret in Variables
6. Go to show assistant and search for Fortanix-Secret-Management
7. Configure all the listed paramaters:
   * FORTANIX_API_ENDPOINT, eg: apac.smartkey.io 
   * FORTANIX_API_KEY, eg: $(FORTANIX_API_KEY)
   * FORTANIX_SECURITY_OBJECT_NAME, name of a Security Object(SECRET)
   * FORTANIX_SECURITY_OBJECT_NAME, variable to save the Security Object
9. FORTANIX_SECURITY_OBJECT_NAME can be used for external usage

#### Pre-requisites

1. To build the extension, Node.js v20 or above is required
2. FORTANIX DSM Account
   a. Configure Group, App API key and Security Object(SECRET)
   b. Ensure to enable the EXPORT permission for Security Object(SECRET)
3. Azure DevOps Organization
   a. Configure Publisher, Project, Github repository 

#### Note
* Ensure that the version is upgraded when updating this extension (eg: 1.0.0 -> 1.0.1)
* Never delete an extension that was already uploaded, always update it when making changes.

