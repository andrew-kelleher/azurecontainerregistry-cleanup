# Azure Container Registry Cleanup
To maintain the size of your Azure Container Registry you should regularly delete old images. This script leverages Azure's **az acr repository** command to scan for and delete surplus images.

An example of where this script is useful is where multiple images are created during a continuous integration (CI) process.

Depending on the parameters used it's possible to define the number of images to retain per registry. For example you may wish to retain the 10 most recent images.

*** WARNING: this script deletes the manifest referenced by the image tag and all other tags referencing the manifest. As long as each tag has a unique manifest this won't be an issue. Please run with EnableDelete=no initially to test the behaviour against your container registry ***

## Getting Started
These instructions will allow you to run the PowerShell script. The script can either be run locally or in Azure Cloud Shell.

## Prerequisites
* You need to have Azure CLI and PowerShell installed on the machine, where you are running the script
* Before running the script ensure you're logged into Azure using the **az login** cmdlet

## Parameters
* **AzureRegistryName** (required) - provide the name of the target Azure Container Registry
* **SubscriptionName** (optional) - if login is associated with only one subscription, then you do not need to provide this. If not, this can be used to set the context in which container registry is located
* **Repository** (optional) - specify the repository to scan for surplus images to delete. If omitted all repositories will be be scanned within the specified container registry
* **ImagestoKeep** (optional) - the number of images per repository to retain (default = 10)
* **EnableDelete** (optional) - enable actual deletion of images instead of just scanning for surplus images (default = no, change to "yes" to delete images)


## Examples
* Example 1: **.\acr-cleanup.ps1 -azureregistryname yourregistryname**

In this case, script will default to scanning for images to delete (ImagestoKeep = 10 and EnableDelete = "no")

* Example 2: **.\acr-cleanup.ps1 -azureregistryname yourregistryname -enabledelete yes**

In this case, script will delete any surplus images above the default of 10 images

* Example 3: **.\acr-cleanup.ps1 -azureregistryname yourregistryname -enabledelete yes -imagestokeep 20**

In this case, script will delete any surplus images above 20 images per repository

* Example 4: **.\acr-cleanup.ps1 -azureregistryname yourregistryname -enabledelete yes -repository yourrepositoryname**

In this case, script will delete any surplus images within the "yourrepositoryname" repository

## Dockerfile
Add a Dockerfile to build and run this script inside a Docker container. We use the Azure CLI container and pull in the Power Shell cross platform binaries.
