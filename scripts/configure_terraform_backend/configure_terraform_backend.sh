#!/bin/bash

# Set variables
environment="dev"
identifier=$RANDOM
resourceGroupName="ePortfolio-rg-$environment"
storageAccountName="tfbackend"+$identifier+"sa"
containerName="tfbackend"+$identifier+"cont"
location="eastus"

# Create resource group
az group create --name $resourceGroupName --location $location

# Create storage account
az storage account create \
  --name $storageAccountName \
  --resource-group $resourceGroupName \
  --location $location \
  --sku Standard_LRS \
  --kind StorageV2

# Retrieve storage account connection string
connectionString=$(az storage account show-connection-string --name $storageAccountName --resource-group $resourceGroupName --query "connectionString" --output tsv)

# Create Blob container
az storage container create --name $containerName --connection-string $connectionString --public-access off

# Retrieve storage account access keys
accessKey=$(az storage account keys list --account-name $storageAccountName --resource-group $resourceGroupName --query "[0].value" --output tsv)

echo "Azure Storage Account and Blob container created successfully."
echo "Storage Account Name: $storageAccountName"
echo "Container Name: $containerName"
echo "Access Key: $accessKey"
