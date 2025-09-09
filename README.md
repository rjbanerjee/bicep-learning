# Bicep Learning Repository

This repository contains Azure Bicep templates and examples for learning Infrastructure as Code (IaC) with Azure Bicep. The project demonstrates how to deploy Azure resources including storage accounts, app service plans, and containerized web applications.

## 📁 Repository Structure

```
bicep-learning/
├── main.bicep                     # Main Bicep template
├── README.md                      # This documentation file
├── azure-credential-json/         # Azure credentials configuration
│   └── azure-credential.json      # Template for Azure service principal credentials
├── ga-code/                       # GitHub Actions related code
│   └── ga-example/
│       └── azure-resources.bicep  # Alternative deployment template for CI/CD
└── modules/                       # Reusable Bicep modules
    ├── servicePlan.bicep          # App Service Plan module
    ├── storage.bicep              # Storage Account module
    └── webApp.bicep               # Web Application module
```

## 🚀 What This Repository Deploys

This Bicep template creates the following Azure resources:

- **Storage Account**: A Premium LRS storage account for application data
- **App Service Plan**: A Linux-based B1 SKU App Service Plan
- **Web Application**: A containerized web app running Docker images

## 📋 File Descriptions

### Main Templates

#### `main.bicep`
The primary deployment template that orchestrates all modules. Features:
- Modular architecture using module references
- Parameterized configuration for flexibility
- Deploys storage, app service plan, and web application
- Default configuration deploys nginx demo container
- Includes parameter validation and descriptions

**Key Parameters:**
- `storageName`: Storage account name (5-24 characters, globally unique)
- `location`: Azure region (restricted to specific regions)
- `dockerImage`: Docker image to deploy (default: nginxdemos/hello)
- `namePrefix`: Prefix for resource naming

#### `ga-code/ga-example/azure-resources.bicep`
Alternative deployment template designed for GitHub Actions CI/CD pipeline:
- Similar structure to main.bicep but with different default values
- Uses Ubuntu nginx image instead of nginxdemos/hello
- Relative module references for CI/CD compatibility

### Modules

#### `modules/storage.bicep`
Deploys an Azure Storage Account with:
- StorageV2 kind with Premium LRS SKU
- Configurable name and location
- Parameter validation for storage account naming requirements

#### `modules/servicePlan.bicep`
Creates an App Service Plan with:
- Linux-based hosting environment
- Configurable SKU (default: B1)
- Resource group location inheritance
- Output of plan ID for consumption by web app module

#### `modules/webApp.bicep`
Deploys a containerized web application with:
- Docker container support from Docker Hub
- Linux container configuration
- App Service storage disabled for containers
- Configurable Docker image and tag
- Output of site URL for access

### Configuration

#### `azure-credential-json/azure-credential.json`
Template file for Azure service principal credentials used for authentication:
- Contains placeholder values for Azure AD application
- Required for programmatic deployments
- Should be configured with actual values (keep secure!)

## 🛠️ Prerequisites

- Azure CLI installed and configured
- Azure subscription with appropriate permissions
- Resource group created for deployment
- Docker Hub access (for public images)

## 📖 Usage

### Basic Deployment

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd bicep-learning
   ```

2. **Deploy using Azure CLI:**
   ```bash
   az deployment group create \
     --resource-group <your-resource-group> \
     --template-file main.bicep \
     --parameters storageName=<unique-storage-name> \
                  location=<azure-region> \
                  namePrefix=<your-prefix>
   ```

3. **Deploy with custom parameters:**
   ```bash
   az deployment group create \
     --resource-group myResourceGroup \
     --template-file main.bicep \
     --parameters storageName=myuniquestorage123 \
                  location=westus3 \
                  dockerImage=nginx \
                  dockerImageTag=alpine \
                  namePrefix=myapp
   ```

### GitHub Actions Deployment

Use the template in `ga-code/ga-example/azure-resources.bicep` for CI/CD deployments:

```bash
az deployment group create \
  --resource-group <your-resource-group> \
  --template-file ga-code/ga-example/azure-resources.bicep
```

## 🔧 Customization

### Supported Azure Regions
- `eastus`
- `westus3`
- `southeastasia`
- `centralindia`

### Docker Images
The template supports any publicly available Docker image from Docker Hub. Popular options:
- `nginxdemos/hello:latest` (default)
- `nginx:latest`
- `ubuntu/nginx:latest`
- Custom images from your registry

### Storage Account Configuration
- **Kind**: StorageV2
- **SKU**: Premium_LRS
- **Tier**: Hot (configured in commented section)

## 📝 Parameters Reference

| Parameter | Type | Default | Description | Constraints |
|-----------|------|---------|-------------|-------------|
| `storageName` | string | `spacetestapp` | Storage account name | 5-24 characters, globally unique |
| `location` | string | `westus3` | Azure region | Must be from allowed list |
| `dockerImage` | string | `nginxdemos/hello` | Docker image name | Any valid Docker Hub image |
| `dockerImageTag` | string | `latest` | Docker image tag | Any valid tag |
| `namePrefix` | string | `paulon` | Resource name prefix | Used for app plan and web app naming |

## 🔍 Outputs

The template provides the following outputs:
- `siteUrl`: The URL of the deployed web application

## 🏗️ Architecture

The solution follows a modular architecture pattern:

```
main.bicep
├── modules/storage.bicep (Storage Account)
├── modules/servicePlan.bicep (App Service Plan)
└── modules/webApp.bicep (Web Application)
    └── depends on: App Service Plan
```

## 📚 Learning Objectives

This repository demonstrates:
- **Bicep Modules**: Reusable infrastructure components
- **Parameter Validation**: Using decorators for input validation
- **Resource Dependencies**: Proper dependency management between resources
- **Output Usage**: Passing data between modules
- **Best Practices**: Modular, maintainable infrastructure code
- **Container Deployment**: Deploying containerized applications to Azure

## 🔒 Security Considerations

- Store Azure credentials securely (use Azure Key Vault in production)
- Keep `azure-credential.json` out of version control with actual values
- Use managed identities when possible instead of service principals
- Enable HTTPS for production deployments (currently commented out)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test deployments
5. Submit a pull request

## 📄 License

This project is for educational purposes. Please refer to your organization's policies for usage guidelines.

---

**Note**: This is a learning repository. For production use, consider additional security measures, monitoring, and backup strategies.
