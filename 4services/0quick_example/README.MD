```yaml
# Deploying HelloK8s Application with NodePort Service

## Introduction
In this setup, we will deploy the HelloK8s application using Kubernetes with a NodePort service. The HelloK8s application is a simple web service that returns a greeting message along with the pod name.

## Steps

### 1. Apply Service Configuration
```bash
kubectl apply -f service.yaml
```
This command deploys the NodePort service configuration defined in `service.yaml`, which exposes the application on a specific port across all nodes in the cluster.

### 2. Verify Service Creation
```bash
kubectl get service hellok8s-svc
```
Ensure that the NodePort service `hellok8s-svc` is created successfully and note the node port allocated for accessing the application.

### 3. Apply Deployment Configuration
```bash
kubectl apply -f deployment.yaml
```
This command deploys the deployment configuration defined in `deployment.yaml`, which creates multiple replicas of the HelloK8s application pods.

### 4. Verify Deployment
```bash
kubectl get deployments
```
Check if the deployment named `hellok8s` is created and ready, and if the desired number of pods are running.

### 5. Access the Application
```bash
curl http://<node-ip>:<node-port>
```
Use `curl` to access the application by specifying the IP address of any node in the cluster along with the node port allocated for the service. You should see a greeting message along with the pod name.

### Expected Output
- Each `curl` request should return a greeting message from one of the pods deployed by the `hellok8s` deployment.

## Conclusion
You have successfully deployed the HelloK8s application using Kubernetes with a NodePort service, allowing access to the application across all nodes in the cluster on a specific port. Feel free to explore more about Kubernetes services and deployments.
