# Service Discovery in Kubernetes

Learn how we can find the running services using service discovery.

## What is service discovery?

Given that we have a few applications running in our cluster, each backed by a Kubernetes service providing a stable endpoint that we can use to reach them, we still need a way to actually find these services. That is, if `app-a` wants to talk to `app-b` using `service-b`, how does it know where it should send requests to?

In a previous example, we have used the service IP directly, which is better than hardcoding the pods’ IPs, as it will not change as pods come and go. But let’s see what happens if we recreate this same service:

```yaml
spec:
  containers:
  - name: nginx-container
    image: nginx
```

If there was any service running, the service IP would have changed.

Even though that’s a lot more stable than the pods’ IPs, we don’t want to run the risk of having to find and change this IP address everywhere it is being used. Hardcoding IP addresses also never feels quite right.

---

### Example: Service Discovery in Kubernetes

Let's illustrate service discovery in Kubernetes with an example involving two microservices: `frontend` and `backend`.

1. **Deployment**:
   
   Suppose we deploy the `frontend` and `backend` microservices in our Kubernetes cluster. Each microservice is exposed through a Kubernetes service.

2. **Service Discovery**:

   - **DNS-Based Service Discovery**:
   
     Kubernetes automatically assigns DNS names to services. For example, the `backend` service might be assigned the DNS name `backend-service`. The DNS name resolves to the IP address of the service dynamically.
   
   - **Environment Variables**:

     Kubernetes injects environment variables into pods, containing information about other services. For instance, an environment variable named `BACKEND_SERVICE_HOST` might contain the IP address of the `backend` service.

3. **Usage**:

   - Instead of hardcoding IP addresses, the `frontend` service can make requests to `backend-service` as if it were a domain name. Kubernetes handles DNS resolution, ensuring requests are routed correctly.
   
   - Alternatively, the `frontend` service can use environment variables injected by Kubernetes to dynamically discover and connect to the `backend` service.

By leveraging service discovery mechanisms provided by Kubernetes, applications within the cluster can communicate reliably with each other, even as the underlying infrastructure scales and changes. This promotes flexibility, resilience, and maintainability in distributed systems.

---

By understanding and utilizing service discovery in Kubernetes, applications can dynamically locate and communicate with other services within the cluster without relying on hardcoded IP addresses or manual configuration. Instead, Kubernetes provides DNS-based resolution and environment variables to facilitate seamless communication between services.

---

