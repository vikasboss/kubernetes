# Kubernetes Deployment Chapter README

## Introduction
In this chapter, you learned about Kubernetes Deployments, which implement several cloud-native features. The Deployment controller, running on the Kubernetes control plane, ensures that the current state of the cluster matches the desired state specified by the user.

## Key Concepts
- **Deployment Controller**: Responsible for managing Deployments and ensuring that the desired state is maintained.
- **Pod Specification**: Deployments wrap a Pod specification, which in turn wraps a container containing the application and its dependencies.
- **Self-healing**: Kubernetes Deployments support self-healing capabilities. If a Pod or Node fails, Kubernetes automatically replaces or fixes it to maintain the desired state.

## Hands-on Experience
You utilized `kubectl` to deploy an application using a Deployment object and tested self-healing functionality by manually breaking Pods and Nodes. Kubernetes automatically fixed or replaced any lost Pods, demonstrating the self-healing capabilities of Deployments.

## Observations
- Deployed a Kubernetes Deployment named `qsk-deploy` with five replicas.
- Used `kubectl get pods` to observe the running Pods in the cluster.
- Manually deleted one of the Pods (`qsk-deploy-6cb45dc966-gb9ns`) to simulate a failure.
- Observed Kubernetes automatically replacing the deleted Pod (`qsk-deploy-6cb45dc966-zmzxg`) to maintain the desired state.

## Additional Information
- **Namespace**: Your project is using several Kubernetes namespaces, including `kube-system`, `kube-public`, `kube-node-lease`, `default`, and `container-registry`.
- **Node**: The Kubernetes cluster consists of a single node named `lucifer-vostro-15-3568`.

## Next Steps
- Experiment further with Kubernetes Deployments to gain more hands-on experience.
- Explore other Kubernetes concepts and features to deepen your understanding of container orchestration.
