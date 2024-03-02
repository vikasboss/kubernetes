# Kubernetes Project README

## Deploying a Pod

1. Check the available nodes:
    ```bash
    kubectl get nodes
    ```

2. Apply the Pod configuration from `pod.yaml`:
    ```bash
    kubectl apply -f pod.yaml
    ```

3. Verify the Pod creation:
    ```bash
    kubectl get pods
    ```

4. Describe the Pod for detailed information:
    ```bash
    kubectl describe pods first-pod
    ```

5. Deleting and recreating the Pod:
    ```bash
    kubectl delete pods first-pod
    kubectl apply -f pod.yaml
    ```

## Creating a Service

1. Apply the Service configuration from `svc-local.yaml`:
    ```bash
    kubectl apply -f svc-local.yaml
    ```

2. Verify the Service creation:
    ```bash
    kubectl get svc
    ```

3. Deleting the Service:
    ```bash
    kubectl delete svc svc-local
    ```

## Final Cleanup

1. Delete the Pod:
    ```bash
    kubectl delete pods first-pod
    ```

2. Delete the Service:
    ```bash
    kubectl delete svc svc-local
    ```

## Notes

- Replace `pod.yaml` and `svc-local.yaml` with the actual file names containing your Pod and Service configurations.
- Ensure that the Kubernetes configurations match your setup and requirements.
- Verify the status of resources after each command to ensure successful execution.

# Kubernetes Interactions: Playing with Running Pods

## Overview

In this module, we explore various ways to interact with running pods in Kubernetes. From streaming logs to executing commands and eventually killing pods, we'll cover essential operations for managing and troubleshooting applications deployed in a Kubernetes cluster.

## Streaming Logs

One of the fundamental aspects of monitoring applications in Kubernetes is streaming their logs. This enables real-time visibility into application behavior and diagnostics. 

To stream logs from a pod, use the `kubectl logs` command with the `--follow` flag:

```bash
kubectl logs --follow <pod-name>
```

This command continuously streams logs from the specified pod, allowing you to monitor application output as it occurs.

## Executing Commands

Interacting with containers running inside pods is crucial for debugging and maintenance tasks. Kubernetes allows you to execute commands directly within a container using the `kubectl exec` command.

To execute a command within a pod's container, use:

```bash
kubectl exec <pod-name> -- <command>
```

You can also start an interactive session within the container using the `-it` flags:

```bash
kubectl exec -it <pod-name> -- bash
```

## Killing Pods

In certain scenarios, you may need to terminate pods either to simulate failures or remove unnecessary resources. Kubernetes provides methods to delete pods either by name or by manifest file.

To delete a pod by name:

```bash
kubectl delete pod <pod-name>
```

Or, delete a pod using its manifest file:

```bash
kubectl delete -f <pod-manifest.yaml>
```

## Conclusion

Interacting with running pods in Kubernetes is essential for managing and troubleshooting applications effectively. By streaming logs, executing commands, and terminating pods when necessary, you can maintain the health and performance of your Kubernetes workloads.

---
This module covers essential operations for interacting with running pods in Kubernetes, including streaming logs, executing commands, and terminating pods. Understanding these operations is crucial for effective application management and troubleshooting in Kubernetes environments.