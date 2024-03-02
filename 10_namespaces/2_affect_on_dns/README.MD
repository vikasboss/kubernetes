# How Namespaces Affect Service’s DNS

Learn how namespaces affect service’s DNS.

We'll cover the following:

## Accessing Service’s DNS Using Namespace

As we have seen before, when we create a service, Kubernetes will allow us to access that service with a DNS entry using the service name. So if we have a service called `my-service`, we can access it with something like ＄ curl http://my-service. These DNS entries are also scoped by namespace, so the path will be `<service-name>.<namespace-name>`, and when the namespace-name is omitted, the current namespace is assumed. Using the previous example, it would be the same thing as calling `http://my-service.default`. Let’s see that in action.

To make it easier to see what’s happening in our example, we will use the `hellok8s` image we have built before, running a different version in each namespace, and then we will create the exact same service in both namespaces.

### Example Overview of a Namespace

We will first create two pods running the `hellok8s` image, one in each namespace:

```yaml
# pods.yaml
apiVersion: v1
kind: Pod
metadata:
  namespace: default
  name: hellok8s
  labels:
    app: hellok8s
spec:
  containers:
  - name: hellok8s-container
    image: brianstorti/hellok8s:v3
```

We can create the pods using the following command:

```bash
kubectl apply -f namespace.yaml

kubectl apply -f pods.yaml
# pod/hellok8s created
# pod/hellok8s created
```

And then create the same service in both namespaces:

```yaml
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: hellok8s-svc
spec:
  selector:
    app: hellok8s
  ports:
  - port: 4567
    targetPort: 4567
```

### Creating the Service

Apply the manifests using the following commands:

```bash
kubectl apply -f service.yaml -n default
# service/hellok8s-svc created

kubectl apply -f service.yaml -n my-namespace
# service/hellok8s-svc created
```

Now that we have one pod and one service running in each namespace, we can test things out. Let’s first open an interactive session in our container running in the default namespace:

```bash
kubectl exec -it hellok8s -- sh
```

Since we didn’t use the `-n` flag, the default namespace is assumed. Now that we are inside our container, let’s see how the DNS entries for our services behave:

```bash
curl hellok8s-svc:4567
# [v4] Hello, Kubernetes (from hellok8s)

curl hellok8s-svc.default:4567
# [v4] Hello, Kubernetes (from hellok8s)

curl hellok8s-svc.my-namespace:4567
# [v3] Hello, Kubernetes, from hellok8s!
```

We can see that when we used `hellok8s-svc` and `hellok8s-svc.default`, we accessed the same service that is running in the default namespace and serving requests to the container running v4.

Let’s now see how that’s different when we run from the container in my-namespace:

```bash
kubectl exec -it hellok8s -n my-namespace -- sh

# Now inside the container

curl hellok8s-svc:4567
# [v3] Hello, Kubernetes, from hellok8s!

curl hellok8s-svc.default:4567
# [v4] Hello, Kubernetes (from hellok8s)
```

And as expected, things look a little bit different. When we use the full path (`hellok8s-svc.<namespace-name>`), we get the same response. However, we access the service running in the current namespace (serving our v3) using just `hellok8s-svc`.

```

This README explains how namespaces affect service's DNS in Kubernetes, demonstrating how to access services using different namespaces and highlighting the scoping of DNS entries by namespaces.