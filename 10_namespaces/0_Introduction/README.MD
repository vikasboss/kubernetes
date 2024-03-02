# Getting Started

An overview of namespaces and how they are used.

We'll cover the following:

## Introduction

Most resources in Kubernetes will live in a namespace. All the pods, deployments, services, configmaps, and everything else we have created so far are all running in the default namespace; that (as the name implies) is where resources will run if we don’t explicitly say we want them to run somewhere else.

We can create other namespaces if we want, and they can help us organize our resources the same way we can organize our code with modules or packages. It should be clear, though, that namespaces do not provide strong security boundaries. Resources from one namespace can still access resources from another.

So let’s see what changes when we work with different namespaces.

## Creating a Namespace

Like everything else, namespaces can be created with a manifest file. That is as simple as it gets; we just need to give it a name:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace
```

Now, if we try to list all the namespaces, we should see it was created:

```bash
kubectl apply -f namespace.yaml
# namespace/my-namespace created

$ kubectl get namespaces
# NAME            STATUS
# default         Active
# docker          Active
# ingress-nginx   Active
# kube-public     Active
# kube-system     Active
```

### Accessing the Namespace

We can see our `my-namespace` was created, and we can also notice we have a couple of other namespaces active as well. For example, we have `ingress-nginx` that was created for us when we installed the nginx ingress controller in a previous chapter, and that is a good example of a use-case for namespaces. All the resources that are running in these namespaces are related to the ingress controller, and we probably don’t want to see these resources when we run something like `kubectl get pods`. We can, however, see resources from a specific namespace using the `-n` flag with `kubectl`:

```bash
kubectl get pods -n ingress-nginx
# NAME                                        READY   STATUS
# nginx-ingress-controller-57548b96c8-mwkrp   1/1     Running
```

We can also use the `--all-namespaces` flag to see resources from all namespaces, and we can combine that with `kubectl get all` to see everything we have running in our cluster:

```bash
kubectl get pods --all-namespaces
kubectl get all --all-namespaces
```

Feel free to explore further and experiment with namespaces to organize and manage your Kubernetes resources effectively.

```  
This README provides an introduction to namespaces in Kubernetes and demonstrates how to create and access namespaces using `kubectl`. It also emphasizes the importance of namespaces in organizing and managing resources within a Kubernetes cluster.