# Managing Resource Limits and Requests in Kubernetes

This chapter covers various aspects of managing resource limits and requests for containers in Kubernetes.

## Recap

Here's a summary of the key points covered in this chapter:

- **Containers without resource limits**: Containers without resource limits can affect other applications sharing the same worker node, leading to resource contention issues.

- **Defining resource requests**: By defining resource requests in pod specifications, Kubernetes ensures that a pod is only scheduled on a worker node that can fulfill those requests. This helps in efficient resource allocation.

- **Exceeding resource requests**: Containers can use more resources than they requested. While Kubernetes can throttle CPU usage beyond the specified limit, it terminates processes that attempt to exceed memory limits, depending on the `restartPolicy` defined for the pod.

- **Defining resource limits**: Kubernetes allows us to explicitly limit the resources a container is allowed to use. CPU usage is throttled if it exceeds the limit, while memory usage leads to process termination.

- **Using LimitRange**: LimitRange in Kubernetes enables the definition of default resource limits and requests for containers in a namespace. This ensures consistent resource allocation across all containers.

By understanding and effectively managing resource limits and requests, Kubernetes users can optimize resource utilization, prevent resource contention, and ensure cluster stability.

