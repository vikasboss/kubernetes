# Kubernetes Deployment Chapter

## Introduction
In this chapter, you learned about Kubernetes Deployments, which implement several cloud-native features. The Deployment controller, running on the Kubernetes control plane, ensures that the current state of the cluster matches the desired state specified by the user.

## Key Concepts
- **Deployment Controller**: Responsible for managing Deployments and ensuring that the desired state is maintained.
- **Pod Specification**: Deployments wrap a Pod specification, which in turn wraps a container containing the application and its dependencies.
- **Self-healing**: Kubernetes Deployments support self-healing capabilities. If a Pod or Node fails, Kubernetes automatically replaces or fixes it to maintain the desired state.

## Hands-on Experience
You utilized `kubectl` to deploy an application using a Deployment object and tested self-healing functionality by manually breaking Pods and Nodes. Kubernetes automatically fixed or replaced any lost Pods, demonstrating the self-healing capabilities of Deployments.

## Observations
- Deployed a Kubernetes Deployment named `qsk-deploy` with five replicas.
- Used `kubectl get pods` to observe the running Pods in the cluster.
- Manually deleted one of the Pods (`qsk-deploy-6cb45dc966-gb9ns`) to simulate a failure.
- Observed Kubernetes automatically replacing the deleted Pod (`qsk-deploy-6cb45dc966-zmzxg`) to maintain the desired state.

## Additional Information
- **Namespace**: Your project is using several Kubernetes namespaces, including `kube-system`, `kube-public`, `kube-node-lease`, `default`, and `container-registry`.
- **Node**: The Kubernetes cluster consists of a single node named `lucifer-vostro-15-3568`.

## Next Steps
- Experiment further with Kubernetes Deployments to gain more hands-on experience.
- Explore other Kubernetes concepts and features to deepen your understanding of container orchestration.


# Kubernetes Deployment Management Module

## Introduction
Welcome to the Kubernetes Deployment Management Module! This module provides comprehensive guidance on managing deployments in Kubernetes. Whether you're new to Kubernetes or looking to enhance your skills, this module covers essential concepts and practical techniques to effectively manage deployments in a Kubernetes environment.

### Introduction to Deployment
In Kubernetes, managing pods directly is not recommended due to the lack of automatic rescheduling when a pod dies. Instead, we use Deployments, which offer several advantages:
- Ensuring pod rescheduling upon failure.
- Facilitating scaling applications by adjusting the number of replicas.
- Handling the rollout of new application versions without downtime.
- Supporting easy rollback of bad releases.

Before diving into deployment management, let's introduce a sample application written in Ruby, packaged as a Docker image, and defined using a simple Sinatra web server.

```ruby
# app.rb
require "sinatra"

set :bind, "0.0.0.0"

get "*" do
  "[v1] Hello, Kubernetes!\n"
end
```

### Defining Our Deployment Manifest
To deploy our application in Kubernetes, we define a Deployment manifest, specifying details such as replicas, selectors, and container images.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hellok8s
  template:
    metadata:
      labels:
        app: hellok8s
    spec:
      containers:
        - name: hellok8s
          image: brianstorti/hellok8s:v1
```

### Restarting Failed Pods
Kubernetes automatically handles pod rescheduling upon failure. Killing a pod demonstrates Kubernetes' ability to maintain the desired state.

### Scaling Up/Down Our Application
Deployments enable scaling applications by adjusting the number of replicas. We can easily scale our application up or down based on demand.

### Rolling Out Releases
Rolling Out Releases involves deploying new versions of applications seamlessly. Kubernetes provides strategies for updating deployments without downtime, enabling efficient release management.

### Controlling the Rollout Rate
Fine-tuning deployment rollout rates ensures smooth transitions between application versions while maintaining system stability and reliability.

## Conclusion
Mastering deployment management in Kubernetes is essential for efficiently deploying and maintaining containerized applications. By understanding deployment concepts and best practices, users can optimize application performance and scalability in Kubernetes environments.

Feel free to explore each section in detail to enhance your Kubernetes deployment management skills!



# Rolling Out Releases with Kubernetes

Welcome to the Rolling Out Releases with Kubernetes module! In this module, you will learn how to effectively roll out new versions of your applications using Kubernetes. Whether you're updating to the latest features or fixing bugs, Kubernetes provides robust capabilities for managing application updates seamlessly.

## Releasing New Versions

Before diving into the release process, let's prepare a new version of our application. We'll create a v2 version with updated functionality or bug fixes. Once the new version is ready, we'll build and push the Docker image to DockerHub.

```ruby
# v2 of our application
get "*" do
  "[v2] Hello, Kubernetes!\n"
end
```

After pushing the new image to DockerHub, updating the deployment manifest to use the v2 image is all that's needed to release the new version.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hellok8s
  template:
    metadata:
      labels:
        app: hellok8s
    spec:
      containers:
        - name: hellok8s
          image: brianstorti/hellok8s:v2
```

## Rolling Update

With the deployment manifest updated, Kubernetes initiates a rolling update process. Pods running the v1 version are gradually terminated, while pods running the v2 version are created. This rolling update strategy ensures minimal disruption to the application.

### Controlling the Rollout Rate

To control the rollout rate and manage resource utilization effectively, Kubernetes offers the `maxSurge` and `maxUnavailable` properties. These properties define the maximum number of pods that can exceed the desired replica count and the maximum number of unavailable pods during the update process.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s
spec:
  strategy:
     rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  replicas: 3
```

## Using a Different Rollout Strategy

In addition to the rolling update strategy, Kubernetes supports the Recreate strategy. Unlike rolling update, the Recreate strategy terminates all existing pods before creating pods with the new version. While this may introduce downtime, it ensures a clean transition to the new version.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s2
spec:
  strategy:
    type: Recreate
  replicas: 3
  selector:
    matchLabels:
```

By mastering the rolling out releases with Kubernetes, you can confidently manage application updates, improve reliability, and deliver new features to your users seamlessly. Explore each section in detail to enhance your skills and optimize your deployment processes!

# Dealing with Bad Releases in Kubernetes

Welcome to the Dealing with Bad Releases in Kubernetes module! In this module, you will learn strategies for handling bad releases manually and automatically within Kubernetes. Managing releases effectively is crucial for maintaining application reliability and minimizing downtime.

## Manually Blocking the Bad Release

In scenarios where a release introduces unexpected issues or bugs, Kubernetes provides mechanisms for manual rollback. Let's simulate a bad release by introducing a buggy version of our application.

```ruby
# Buggy version of our application
require "sinatra"

set :bind, "0.0.0.0"

$counter = 0

get "*" do
  $counter += 1
  if $counter > 3
    raise "Whoops, something is wrong"
```

After building and pushing the buggy image to DockerHub, update the deployment manifest to use this new image.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hellok8s
  template:
    metadata:
      labels:
        app: hellok8s
    spec:
      containers:
        - name: hellok8s
          image: brianstorti/hellok8s:buggy
```

We can then apply this manifest to initiate the rolling update. If issues arise, Kubernetes allows us to manually rollback the release using the following command:

```bash
kubectl rollout undo deployment hellok8s
```

## Automatically Blocking Bad Releases

To prevent bad releases automatically, Kubernetes offers readiness probes. These probes allow Kubernetes to verify that a container is ready to receive requests before directing traffic to it. Let's enhance our deployment manifest to include a readiness probe.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hellok8s
  template:
    metadata:
      labels:
        app: hellok8s
    spec:
      containers:
        - name: hellok8s
          image: brianstorti/hellok8s:buggy
          readinessProbe:
            periodSeconds: 1
            successThreshold: 5
            httpGet:
              path: /
              port: 4567
```

By specifying a readiness probe, Kubernetes ensures that pods are ready to serve traffic only after meeting specific criteria. If a pod fails the readiness check, Kubernetes prevents it from receiving requests, effectively blocking bad releases automatically.

Explore each section in detail to gain a comprehensive understanding of managing bad releases effectively in Kubernetes, empowering you to maintain application stability and reliability seamlessly!
# Keeping Applications Healthy with Liveness Probes

Welcome to the Keeping Applications Healthy with Liveness Probes module! In this module, you will learn how to use liveness and readiness probes in Kubernetes to ensure the health and availability of your applications.

## livenessProbe and readinessProbe

In Kubernetes, liveness and readiness probes are essential mechanisms for monitoring the health of your application pods.

### livenessProbe

A livenessProbe allows you to define conditions that Kubernetes uses to determine whether a pod is alive and healthy. If the conditions specified by the liveness probe are not met, Kubernetes restarts the pod to attempt to recover it.

Here's an example of a deployment manifest with both liveness and readiness probes:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hellok8s
  template:
    metadata:
      labels:
        app: hellok8s
    spec:
      containers:
        - name: hellok8s
          image: brianstorti/hellok8s
          readinessProbe:
            httpGet:
              path: /
              port: 4567
          livenessProbe:
            httpGet:
              path: /
              port: 4567
```

### Running custom commands for liveness and readiness probes

While HTTP requests are commonly used for liveness and readiness probes in web applications, Kubernetes also supports running custom commands to check the health of containers.

For example, you can define a custom script called `check_health.sh` to perform health checks within your container:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hellok8s
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hellok8s
  template:
    metadata:
      labels:
        app: hellok8s
    spec:
      containers:
        - name: hellok8s
          image: brianstorti/hellok8s
          readinessProbe:
            exec:
              command:
                - /bin/bash
                - -c
                - /app/check_health.sh
          livenessProbe:
            exec:
              command:
                - /bin/bash
                - -c
                - /app/check_health.sh
```

By running custom scripts or commands, you can perform more complex health checks to ensure your application is functioning correctly.

Explore each section in detail to understand how to leverage liveness and readiness probes effectively in Kubernetes, ensuring the reliability and availability of your applications!
# Chapter Summary: Recap

In this chapter, we covered various aspects related to managing deployments and ensuring the health of applications in Kubernetes. Let's recap what we've learned:

## Deployments

- **Deployments** are high-level Kubernetes resources used for managing pods.
- They facilitate scaling applications by creating and deleting pod replicas as needed.

## Release Strategies

- We explored two main strategies for rolling out new versions of applications: **Recreate** and **RollingUpdate**.
- **Recreate Strategy**: Guarantees no simultaneous running of different versions but may involve a short downtime.
- **RollingUpdate Strategy**: Gradually replaces old pods with new ones, allowing for zero-downtime deployments.
- We can control the rollout rate using parameters like **maxSurge** and **maxUnavailable**.

## Probes for Health Monitoring

- **Readiness Probe**: Used to determine when a container is ready to serve traffic, preventing premature traffic routing.
- **Liveness Probe**: Monitors the health of a container and automatically restarts it if it becomes unhealthy.
- Both probes can use HTTP requests or custom commands/scripts to check the container's health status.

## Conclusion

Understanding deployment strategies and implementing effective health monitoring mechanisms are crucial for maintaining the stability and availability of applications in Kubernetes. By mastering these concepts, you can ensure smoother deployments and minimize potential downtime, contributing to a more robust and reliable application infrastructure.