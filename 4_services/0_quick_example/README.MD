# Introduction to Services

In Kubernetes, pods are ephemeral, and their names or IP addresses cannot be relied upon to remain stable. This presents challenges, especially when scaling deployments or enabling communication between different applications within the cluster. To address these issues, Kubernetes provides a resource called "Service."

## Problems with Current Setup
Before diving into Services, let's understand the limitations of our current setup:
1. **Limited Accessibility**: Using port-forwarding restricts access to applications within the Kubernetes cluster, making them inaccessible to users outside the cluster.
2. **Unreliable Communication**: Without a stable endpoint, applications within the cluster lack a reliable way to communicate with each other. Hardcoding pod IP addresses is not a sustainable solution as pods are frequently re-created, leading to IP changes.
3. **Single Point of Contact**: Requests are directed to a single pod even if multiple replicas of the application are running. This results in uneven distribution of traffic and underutilization of resources.

## What is a Service?
A Service in Kubernetes provides a stable endpoint for accessing pods. It acts as a mediator, receiving incoming requests and distributing them among the pods it manages. By abstracting away the details of individual pods, Services enable seamless communication between different components within the cluster.

Stay tuned as we delve deeper into the intricacies of Kubernetes Services and how they address the challenges posed by dynamic pod environments.


This introduction provides an overview of the challenges posed by dynamic pod environments and introduces the concept of Kubernetes Services as a solution to these challenges.

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
