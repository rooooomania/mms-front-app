# Build Specification Documentation

## Overview
The `build_spec.yaml` file is a critical component in the CI/CD pipeline for the Membership Management System frontend application. It defines the build process that runs within the OCI DevOps Build Pipeline, orchestrating the containerization and deployment preparation of the application.

## Purpose
This file serves several key purposes:
- Defines the build environment and configuration
- Manages secrets and authentication for various services
- Packages the application as a Docker container
- Creates and publishes Helm charts for Kubernetes deployment
- Ensures consistent versioning across deployments

## Structure and Components

### Environment Configuration
```yaml
version: 0.1
component: build
timeoutInSeconds: 6000
shell: bash
env:
  variables:
    # Local variables for build configuration
  vaultVariables:
    # Secure credentials stored in OCI Vault
  exportedVariables:
    # Variables made available to subsequent pipeline stages
```

The environment section defines:
- Local variables like namespace and cluster information
- Secure credentials retrieved from OCI Vault (authentication tokens, registry credentials)
- Variables that will be exported for use in later pipeline stages

### Build Steps

#### 1. Export Variables
This step generates a unique build identifier using the Git commit hash, which is used for versioning and traceability throughout the deployment process.

#### 2. Confirm Secrets Availability
This step:
- Ensures kubectl is installed
- Creates a kubeconfig file for the target Kubernetes cluster
- Verifies that Docker registry secrets are available in the cluster
- Creates secrets if they don't exist

#### 3. Helm Chart Packaging
This step:
- Updates Chart.yaml and values.yaml using environment variables
- Packages the Helm chart
- Extracts the version information
- Authenticates with the Helm repository
- Pushes the packaged chart to the repository

#### 4. Docker Image Building
This step builds the Docker container image for the application using the Dockerfile in the project root.

### Output Artifacts
The build process produces a Docker image as its primary artifact, which is then pushed to the container registry.

## Integration Points
The build specification integrates with several external systems:
- OCI Container Registry for storing Docker images
- OCI Vault for secure credential management
- Kubernetes cluster for secret verification
- Helm repository for chart storage

## Usage in Development Workflow
When developers commit changes to the repository:
1. The build pipeline is triggered
2. `build_spec.yaml` executes its steps in sequence
3. The resulting Docker image and Helm chart are published
4. These artifacts are then available for deployment to the target environment

## Error Handling
The specification includes error handling mechanisms for critical steps, ensuring that failures are properly reported and, where possible, remediated.

## Security Considerations
The build specification implements several security best practices:
- Using OCI Vault for sensitive credential storage
- Restricting permissions on kubeconfig files
- Using Kubernetes secrets for Docker registry authentication
- Implementing proper error handling to prevent information leakage
