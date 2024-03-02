# Defining Resource Requests in Kubernetes

In this section, we'll learn how to define resource requests for our pods in Kubernetes.

## Defining Request

When creating a pod in Kubernetes, we can specify how much CPU and memory it requires. Kubernetes then schedules the pod only on nodes that have sufficient capacity to meet these resource requests.

Let's take a look at an example manifest file for a pod named `busybox`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  containers:
  - name: busybox-container
    image: busybox
    command: ["dd", "if=/dev/zero", "of=/dev/null"]
    resources:
      requests:
        cpu: 500m
        memory: 5Mi
```

In this manifest:
- We define a pod named `busybox` running the `busybox` container.
- The container executes a command that consumes CPU.
- We specify the resource requests: 500 milliCPU (0.5 CPU core) and 5 megabytes of memory.

Now, let's test this pod and observe its behavior:

```bash
kubectl apply -f busybox.yaml
kubectl exec -it busybox -- top
```

We'll see the container consuming CPU, potentially exceeding the requested amount.

Additionally, we can attempt to create another pod named `hungry-busybox` with a higher CPU request:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hungry-busybox
spec:
  containers:
  - name: hungry-busybox-container
    image: busybox
    command: ["dd", "if=/dev/zero", "of=/dev/null"]
    resources:
      requests:
        cpu: 700m
        memory: 5Mi
```

However, since our cluster has limited resources, the `hungry-busybox` pod will remain in a pending state due to insufficient CPU.

By defining resource requests, Kubernetes ensures efficient resource allocation and prevents resource contention among pods.
```

This README provides an overview of defining resource requests for pods in Kubernetes and demonstrates how Kubernetes handles resource allocation based on these requests.