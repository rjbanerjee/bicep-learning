# Bicep Learning Repository

A comprehensive learning repository for Azure Bicep Infrastructure as Code (IaC) demonstrating various Azure resource deployments using modular architecture.

## 📁 Repository Structure

```
bicep-learning/
├── azure.yaml                           # Azure configuration with basic GitHub Actions
├── main.bicep                          # Main deployment template with modular architecture
├── storage.bicep                       # Empty storage template (placeholder)
├── ga-code/
│   └── ga-example/
│       └── azure-resources.bicep       # GitHub Actions example deployment
└── modules/
    ├── servicePlan.bicep               # App Service Plan module
    ├── storage.bicep                   # Storage Account module
    └── webApp.bicep                    # Web Application module
```

## 🎯 Learning Objectives

This repository demonstrates:
- **Modular Bicep Architecture**: Breaking down infrastructure into reusable modules
- **Parameter Management**: Using parameters with validation, descriptions, and constraints
- **Resource Dependencies**: Understanding how modules depend on each other
- **Output Management**: Exposing values from modules for use in other resources
- **Best Practices**: Following Azure Bicep naming conventions and security practices

## 📋 File Descriptions

### Root Level Files

#### `azure.yaml`
Azure configuration file containing:
- Project metadata (name, description, icon)
- Basic GitHub Actions workflow configuration
- Simple "Hello World" demonstration

#### `main.bicep`
The main orchestration template that:
- Defines global parameters with validation rules
- Orchestrates multiple modules (storage, service plan, web app)
- Demonstrates parameter passing between modules
- Outputs the final website URL
- **Key Features:**
  - Storage name validation (5-24 characters)
  - Location restrictions to specific Azure regions
  - Docker container configuration for web apps

#### `storage.bicep`
Empty file - placeholder for future storage configurations

### ga-code/ga-example/

#### `azure-resources.bicep`
Simple example demonstrating:
- Basic storage account deployment
- Parameter usage for location and naming
- Premium LRS storage configuration

### modules/

#### `servicePlan.bicep`
App Service Plan module featuring:
- Linux-based hosting plan
- Configurable SKU (defaults to B1)
- Resource naming with prefix pattern
- Output of plan ID for dependent resources

#### `storage.bicep`
Storage Account module with:
- Parameter validation for storage naming
- StorageV2 with Premium LRS configuration
- Configurable location parameter

#### `webApp.bicep`
Web Application module that:
- Deploys containerized applications
- Configures Docker registry settings
- Links to App Service Plan via parameter
- Outputs the website URL
- Supports custom Docker images and tags

## 🚀 Deployment Examples

### Basic Deployment
```bash
# Deploy the main template
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters storageName=myuniquestorage location=westus3
```

### Custom Docker Image Deployment
```bash
# Deploy with custom Docker image
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters storageName=myuniquestorage \
               dockerImage=nginxdemos/hello \
               dockerImageTag=latest \
               namePrefix=myapp
```

### GitHub Actions Example
```bash
# Deploy the GA example
az deployment group create \
  --resource-group myResourceGroup \
  --template-file ga-code/ga-example/azure-resources.bicep \
  --parameters storageName=gastorageexample
```

## 📚 Learning Topics Covered

### 1. **Parameter Management**
- String length validation (`@minLength`, `@maxLength`)
- Allowed values restriction (`@allowed`)
- Parameter descriptions for documentation
- Default values and optional parameters

### 2. **Modular Architecture**
- Breaking infrastructure into logical modules
- Parameter passing between modules
- Output consumption from child modules
- Module naming conventions

### 3. **Resource Types**
- **Storage Accounts**: Different SKUs and configurations
- **App Service Plans**: Linux hosting with scalable SKUs
- **Web Apps**: Container-based applications with Docker support

### 4. **Best Practices**
- Consistent naming conventions with prefixes
- Resource grouping and organization
- Parameter validation and constraints
- Output management for resource references

### 5. **Docker Integration**
- Container deployment to Azure App Service
- Docker registry configuration
- Custom image and tag management
- Linux container hosting

## 🛠️ Prerequisites

- Azure CLI installed and configured
- Valid Azure subscription
- Basic understanding of Azure services
- Familiarity with Infrastructure as Code concepts

## 🔗 Useful Commands

```bash
# Validate Bicep template
az deployment group validate --resource-group myRG --template-file main.bicep

# Preview changes
az deployment group what-if --resource-group myRG --template-file main.bicep

# Deploy with parameter file
az deployment group create --resource-group myRG --template-file main.bicep --parameters @parameters.json

# Check deployment status
az deployment group show --resource-group myRG --name deploymentName
```

## 📖 Next Steps

1. **Enhance Modules**: Add more Azure services (databases, networking, etc.)
2. **Parameter Files**: Create environment-specific parameter files
3. **CI/CD Integration**: Expand GitHub Actions for automated deployments
4. **Security**: Implement Key Vault integration for secrets management
5. **Monitoring**: Add Application Insights and monitoring resources

## 🤝 Contributing

This is a learning repository. Feel free to:
- Add new modules and examples
- Improve existing templates
- Document additional learning scenarios
- Share deployment experiences

## 📝 Notes

- Default location is set to `westus3` - adjust based on your requirements
- Storage account names must be globally unique
- The web app is configured for Linux containers by default
- Premium LRS storage is used for demonstration - adjust SKU for cost optimization

---

*Happy Learning with Azure Bicep! 🚀*
