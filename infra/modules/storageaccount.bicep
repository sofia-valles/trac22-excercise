param tags object = {}
param storageAccountName string
param location string = resourceGroup().location

@allowed([
    'Standard_LRS'
    'Standard_GRS'
    'Standard_RAGRS'
    'Standard_ZRS'
    'Premium_LRS'
    'Premium_ZRS'
    'Standard_GZRS'
    'Standard_RAGZRS'
])
@description('Pricing Tier')
param skuName string = 'Standard_LRS'

@allowed([
    'Enabled'
    'Disabled'
])
param publicNetworkAccess string = 'Enabled'
param allowBlobPublicAccess bool = true
param allowSharedKeyAccess bool = true

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
    name: storageAccountName
    location: location
    sku: {
        name: skuName
    }
    kind: 'StorageV2'
    tags: tags
    properties: {
        encryption: {
            services: {
                blob: {
                    enabled: true
                }
                file: {
                    enabled: true
                }
            }
            keySource: 'Microsoft.Storage'
        }
        supportsHttpsTrafficOnly: true
        minimumTlsVersion: 'TLS1_2'
        publicNetworkAccess: publicNetworkAccess
        allowBlobPublicAccess: allowBlobPublicAccess
        allowSharedKeyAccess: allowSharedKeyAccess
        accessTier: 'Hot'
    }
}

output name string = storageAccount.name
output id string = storageAccount.id
