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
