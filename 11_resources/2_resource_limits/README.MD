# Defining Resource Limits in Kubernetes

In this section, we'll learn how to limit the amount of CPU and memory a container can use in Kubernetes.

## Limiting the Container

While defining resource requests helps with scheduling, it doesn't restrict how much CPU or memory a container can consume. To enforce strict resource limits, we use the `limits` property in the pod specification.

Let's create an example pod named `limited-busybox` with CPU limits:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: limited-busybox
spec:
  containers:
  - name: limited-busybox-container
    image: busybox
    command: ["dd", "if=/dev/zero", "of=/dev/null"]
    resources:
      requests:
        cpu: 500m
        memory: 10Mi
      limits:
        cpu: 500m
        memory: 10Mi
```

In this manifest:
- We define a pod named `limited-busybox` with a container running the `busybox` image.
- The container executes a command that consumes CPU.
- We set a limit of 500 milliCPU (0.5 CPU core) for the container.

Now, let's apply this manifest and observe the CPU usage:

```bash
kubectl apply -f limited-busybox.yaml
kubectl exec -it limited-busybox -- top
```

We'll notice that the container's CPU usage is now limited to 500m, enforcing stricter resource usage.

By defining resource limits, Kubernetes ensures that containers do not exceed specified resource constraints, preventing resource contention and maintaining cluster stability.
```

This README provides an overview of defining resource limits for containers in Kubernetes and demonstrates how Kubernetes enforces these limits to manage resource usage effectively.