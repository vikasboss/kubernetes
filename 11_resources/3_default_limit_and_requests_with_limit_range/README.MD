# Managing Resource Limits and Requests with LimitRange in Kubernetes

In this section, we'll explore how to use LimitRange in Kubernetes to define default resource limits and requests for containers.

## Differences between Memory and CPU Limits

When a container reaches its limit for CPU and memory usage, Kubernetes behaves differently. CPU is a compressible resource, meaning Kubernetes can simply stop allocating CPU time to a container that exceeds its limit without terminating the container. However, with memory, Kubernetes kills the process if a container tries to allocate more memory than its limit. Depending on the `restartPolicy` defined for the pod, Kubernetes may restart the container.

## Using LimitRange

LimitRange in Kubernetes allows us to set default resource limits and requests for containers running in a namespace. This ensures consistent resource management across all containers in the namespace.

Let's create an example LimitRange named `memory-limit-range` with default memory and CPU limits:

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: memory-limit-range
spec:
  limits:
  - default:
      memory: 500Mi
      cpu: 200m
    type: Container
```

In this manifest:
- We define a LimitRange named `memory-limit-range` with default memory limit of 500Mi and CPU limit of 200m.
- These default values will be applied to containers that do not explicitly define resource limits and requests.

Now, let's apply this LimitRange to a namespace and observe its effect on pods:

```bash
kubectl apply -f default-limit-range.yaml
kubectl apply -f hellok8s.yaml
kubectl describe pod hellok8s
```

We'll notice that the `hellok8s` pod uses the default CPU limit specified in the LimitRange.

By utilizing LimitRange, Kubernetes ensures consistent resource allocation and prevents resource contention issues in namespaces.
```

This README provides an overview of using LimitRange in Kubernetes to manage default resource limits and requests for containers, ensuring efficient resource utilization and cluster stability.
```