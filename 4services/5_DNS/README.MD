# DNS in Kubernetes

Learn about the DNS service discovery mechanism in Kubernetes.

## Introduction to DNS

Kubernetes provides two different service discovery mechanisms: DNS and injected environment variables.

### Introduction to DNS

Kubernetes provides an out-of-the-box DNS service to resolve service names. Here’s how it works: If you create a service called `service-a`, Kubernetes will add an entry for this service in its DNS, so any pod will be able to call, for example, `http://service-a:4567`. That will be correctly resolved to the service’s IP.

### Example:

Let's illustrate DNS service discovery in Kubernetes with an example involving a service called `hellok8s-svc`.

1. **Deployment**:

   Suppose we deploy the `hellok8s` application backed by a Kubernetes service named `hellok8s-svc`. The service type is `NodePort`, exposing the application on port `4567`.

2. **Service Discovery**:

   - **Kubernetes DNS Resolution**:

     Kubernetes automatically adds an entry for `hellok8s-svc` to its DNS, resolving to the service's IP address. This allows any pod within the cluster to access the service using its DNS name.

3. **Usage**:

   - Pods within the cluster can communicate with the `hellok8s` application by making requests to `http://hellok8s-svc:4567`. Kubernetes handles DNS resolution internally, ensuring requests are routed correctly.

   - This DNS resolution mechanism is independent of the service type (`ClusterIP`, `NodePort`, or `LoadBalancer`) and provides a consistent way for pods to discover and access services within the cluster.

### Command Snippets:

```bash
# Execute a shell session inside a pod
kubectl exec -it hellok8s-7f4c57d446-7j6rd -- sh

# Replace the service IP with your local IP
curl http://10.102.141.32:4567
# Output: [v3] Hello, Kubernetes, from hellok8s-7f4c57d446-7j6rd!

# Access the service using its DNS name
curl http://hellok8s-svc:4567
# Output: [v3] Hello, Kubernetes, from hellok8s-7f4c57d446-lh44f!
```

By leveraging DNS-based service discovery in Kubernetes, applications can communicate seamlessly with other services using human-readable DNS names, reducing reliance on hardcoded IP addresses and simplifying service configuration.

