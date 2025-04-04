# Expamle of Frontend Application

## Overview
This project manages the deployment and configuration of the frontend application on Kubernetes infrastructure within Oracle Cloud Infrastructure (OCI).

## Main Responsibilities
- Provide the frontend user interface for the Membership Management System
- Enable deployment on Kubernetes using Helm charts
- Configure and integrate with OCI's native ingress controller
- Support CI/CD pipelines for automated build and deployment

## **Architecture**
The application is containerized using Docker and deployed to Kubernetes clusters on OCI. It utilizes:
- Helm charts for Kubernetes resource management
- OCI's native ingress controller for traffic management
- Horizontal Pod Autoscaler for scaling
- CI/CD pipelines for automated deployment

## Key Components
- **Helm Charts**: Located in `/helm/front-app/` directory, containing all Kubernetes resource templates
- **Dockerfile**: Defines the container image for the application
- **Build Specification**: Defined in `build_spec.yaml`, manages the OCI DevOps Build Pipeline
- **Configuration Templates**: Templates for Chart metadata and values that are processed during build

## Deployment
The application is deployed through the following process:
1. Build pipeline packages the application into a Docker image
2. Git hash is used as the build identifier
3. Helm chart is generated from templates and packaged
4. Helm deployment applies the chart to the target Kubernetes environment

## Configuration
Key configuration areas include:
- Image configuration (repository, tag, pull policy)
- Service configuration (type, ports)
- Ingress configuration (routing, TLS, hostname)
- OCI-specific ingress parameters (load balancer settings, network configuration)

## Development Workflow
1. Make changes to application code
2. Update Helm templates as needed
3. Test locally using Docker
4. Commit changes to trigger CI/CD pipeline
5. Pipeline builds, packages, and deploys the application

## Security
The application follows security best practices including:
- Storage of sensitive values in Kubernetes secrets
- Use of private container registries with authentication
- Implementation of network policies to restrict traffic
- Following the principle of least privilege for service accounts

## Troubleshooting
For troubleshooting deployment issues:
- Check pod status with `kubectl get pods`
- View logs with `kubectl logs [pod-name]`
- Verify service configuration with `kubectl describe service [service-name]`
- Check ingress status with `kubectl describe ingress [ingress-name]`
