# Set variables
$environment = "dev"
$identifier = Get-Random
$resourceGroupName = "ePortfolio-rg-$environment"
$storageAccountName = "tfbackend"+$identifier+"sa"
$containerName = "tfbackend"+$identifier+"cont"
$location = "eastus"

# Create resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create storage account
New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName Standard_LRS -Kind StorageV2

# Retrieve storage account connection string
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$connectionString = $storageAccount.Context.ConnectionString

# Create Blob container
$context = New-AzStorageContext -ConnectionString $connectionString
New-AzStorageContainer -Name $containerName -Context $context -Permission Off

# Retrieve storage account access keys
$accessKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0]

Write-Host "Azure Storage Account and Blob container created successfully."
Write-Host "Storage Account Name: $storageAccountName"
Write-Host "Container Name: $containerName"
Write-Host "Access Key: $accessKey"
