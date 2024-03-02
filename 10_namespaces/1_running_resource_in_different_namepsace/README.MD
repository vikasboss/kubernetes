# Running Resources in a Different Namespace

Learn how we can use different namespaces for running our resources.

We'll cover the following:

## Defining a Resource

There are two different ways to define the namespace to run a resource in. We can simply use the `-n` flag when we run `kubectl apply`, or we can define that in the resource’s manifest. Let’s use our nginx pod to see how that works.

### Code for `nginx-pod.yaml` file

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx-container
    image: nginx
```

If we apply this manifest without any flags, it will be applied to the default namespaces:

```bash
kubectl apply -f nginx-pod.yaml
# pod/nginx created
```

And if we run it with the `-n` flag, we can apply the manifest in our new namespace:

```bash
kubectl apply -f nginx-pod.yaml -n my-namespace
# pod/nginx created
```

One thing you will notice is that namespaces provide a scope for names, so we can have a pod (or any other resource) with the exact same name (nginx in this case) running in different namespaces.

We can try to list the pods to confirm we have one pod running in each namespace now:

```bash
kubectl get pods
# NAME    READY   STATUS 
# nginx   1/1     Running

kubectl get pods -n my-namespace
# NAME    READY   STATUS   
# nginx   1/1     Running 
```

Another way to define the resource namespace is by explicitly declaring that in the manifest file. So for our nginx pod, it would look like this:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  namespace: my-namespace
spec:
  containers:
  - name: nginx-container
    image: nginx
```

And then we can just `kubectl apply` it without the `-n` flag, and this pod would be created in the defined namespace.
```  
This README explains how to define the namespace for Kubernetes resources using the `-n` flag or by explicitly declaring it in the resource's manifest file. It demonstrates how to apply resources to different namespaces and highlights the scoping provided by namespaces.