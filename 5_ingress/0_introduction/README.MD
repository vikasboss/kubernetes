# Introduction to Ingress

In this chapter, we will explore what Ingress is and how to add an Ingress controller in our Kubernetes cluster.

## Table of Contents

- [Introduction to Ingress](#introduction-to-ingress)
- [Adding an Ingress Controller](#adding-an-ingress-controller)
- [Before We Start](#before-we-start)
- [Ingress in Action](#ingress-in-action)

## Introduction to Ingress

Ingress is a Kubernetes resource used to expose HTTP(S) routes to external users. It acts as a front-facing layer for multiple services, directing incoming requests based on defined rules.

### Adding an Ingress Controller

To utilize the Ingress resource, an Ingress Controller must be running in the cluster. Various open-source controllers are available, each with distinct features. In this example, we will deploy the nginx ingress controller using the following command:

```bash
kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/\
deploy/static/provider/cloud/deploy.yaml
```

Ensure the controller is running by checking the pods:

```bash
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx
```

### Before We Start

Before we proceed, let's prepare our environment by deleting any existing deployments and services:

```bash
kubectl delete deployment,service --all
```

Then, we'll create Services and Deployments for our `hellok8s` and `nginx` applications.

```yaml
# hellok8s.yaml
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

```yaml
# nginx.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
spec:
  selector:
    app: nginx
  ports:
  - port: 1234
```

### Ingress in Action

Now, let's create an Ingress resource to expose our services. We'll start with a simple Ingress routing all requests to the `nginx-svc` service.

```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-ingress
spec:
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-svc
                port:
                  number: 1234
```

Apply the Ingress using:

```bash
kubectl apply -f ingress.yaml
```

Once applied, you can verify its configuration:

```bash
kubectl get ingress
```

Now, requests to `http://localhost` should display the default nginx page.

Next, let's update the Ingress to route requests to different services based on paths. For example, requests to `/hello` should be directed to the `hellok8s-svc` service.

Apply the updated Ingress:

```bash
kubectl apply -f ingress-updated.yaml
```

To run the Ingress on the platform, execute the following port-forward command:

```bash
nohup kubectl port-forward --address 0.0.0.0 -n ingress-nginx service/ingress-nginx-controller 80:80 > /dev/null 2>&1 &
```

Test the Ingress routes:

```bash
curl http://localhost/hello
# [v3] Hello, Kubernetes, from hellok8s-7f4c57d446-qth54!

curl http://localhost
# (nginx welcome page)
```

This concludes our introduction to Ingress, demonstrating how to route traffic to different services based on defined rules.
```
This readme provides an overview of Ingress in Kubernetes, including how to add an Ingress controller, prepare the environment, and configure Ingress rules for routing traffic to different services.