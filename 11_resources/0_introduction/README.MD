# Getting Started: Managing Resource Usage in Kubernetes

In this section, we'll explore how to manage resource usage in Kubernetes and check our allocatable resources. Here's an overview:

## Introduction

When running applications in Kubernetes, they compete for limited resources such as CPU, memory, and storage. To prevent one container from monopolizing resources and affecting others, Kubernetes provides mechanisms to manage resource usage.

## Checking our Allocatable Resources

Before we dive into managing resource usage, let's first check the allocatable resources in our Kubernetes cluster. You can do this by running the following command:

```bash
kubectl describe nodes
```

This command will display information about the nodes in your cluster, including the allocatable resources like CPU, memory, and storage. For example:

```
Allocatable:
  cpu:                2
  ephemeral-storage:  56453061334
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             1944636Ki
  pods:               110
```

Adjust your resource management strategies based on the allocatable resources available in your cluster.

---

By understanding and managing your cluster's resource allocation, you can optimize performance and ensure fair resource distribution among applications.
```

This README provides an introduction to managing resource usage in Kubernetes and a guide on checking allocatable resources in your cluster.