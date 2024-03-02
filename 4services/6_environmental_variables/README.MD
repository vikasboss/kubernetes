# Environment Variables in Kubernetes

Learn about the environment variables service discovery mechanism in Kubernetes.

## Introduction to Environment Variables

Another way to find services is through environment variables. Every container that Kubernetes creates will have environment variables that can be used to find every service that is currently running in the cluster.

### Introduction

For example, let's consider a scenario where we have a Kubernetes deployment named `hellok8s` backed by a service named `hellok8s-svc`. We can access this service using environment variables injected into the pod.

### Example:

1. **Deployment**:

   We deploy the `hellok8s` application using the following YAML manifest:

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     labels:
       app: hellok8s
   spec:
     containers:
     - image: brianstorti/hellok8s:v3
       name: hellok8s-container
   ```

2. **Service**:

   We define a Kubernetes service named `hellok8s-svc` of type `NodePort`:

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: hellok8s-svc
   spec:
     type: NodePort
     selector:
       app: hellok8s
     ports:
     - port: 4567
       nodePort: 30001
   ```

3. **Service Discovery via Environment Variables**:

   - When a pod is created, Kubernetes injects environment variables related to each service into the pod's environment.

   - We can access these environment variables to communicate with the services within the cluster.

4. **Usage**:

   - Inside the pod, we can access the `hellok8s-svc` service using environment variables such as `HELLOK8S_SVC_SERVICE_HOST` and `HELLOK8S_SVC_SERVICE_PORT`.

   - We can use these environment variables to construct URLs and make requests to the service.

### Command Snippets:

```bash
# Execute a shell session inside a pod
kubectl exec -it hellok8s-664f77d78c-49nhw -- sh

# Filter environment variables related to the HELLOK8S service
env | grep HELLOK8S

# Output:
# HELLOK8S_SVC_PORT_4567_TCP=tcp://10.102.141.32:4567
# HELLOK8S_SVC_SERVICE_HOST=10.102.141.32
# HELLOK8S_SVC_PORT_4567_TCP_ADDR=10.102.141.32
# HELLOK8S_SVC_PORT=tcp://10.102.141.32:4567
# HELLOK8S_SVC_SERVICE_PORT=4567
# HELLOK8S_SVC_PORT_4567_TCP_PORT=4567
# HELLOK8S_SVC_PORT_4567_TCP_PROTO=tcp

# Construct the URL using environment variables and make a request to the service
curl $HELLOK8S_SVC_SERVICE_HOST:$HELLOK8S_SVC_SERVICE_PORT
# Output: [v3] Hello, Kubernetes, from hellok8s-7f4c57d446-lh44f!
```

By leveraging environment variables for service discovery, Kubernetes applications can dynamically interact with other services within the cluster, enabling seamless communication and flexible deployment configurations.

---

Feel free to let me know if you need further assistance!