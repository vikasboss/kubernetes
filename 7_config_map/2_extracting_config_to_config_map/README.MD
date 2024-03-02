# Extracting Configs to a ConfigMap

## ConfigMap

In Kubernetes, managing configurations for applications can be challenging, especially when deploying to multiple environments. The use of environment variables directly in manifest files can lead to duplication and inflexibility. Fortunately, Kubernetes offers a solution called ConfigMap, which provides a centralized way to manage configuration data as key-value pairs.

### Creating a ConfigMap

To demonstrate the usage of ConfigMap, let's create a simple ConfigMap called `hellok8s-config` with a single key-value pair:

```yaml
# hellok8s-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: hellok8s-config
data:
  MESSAGE: "It works with a ConfigMap!"
```

Apply this manifest to create the ConfigMap.

### Updating Deployment Configuration

Now, let's update the Deployment configuration to use the values from the ConfigMap for environment variables:

```yaml
# hellok8s-updated.yaml
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
    spec:
      containers:
      - name: hellok8s
        image: <image_name>
        ports:
        - containerPort: 4567
        envFrom:
        - configMapRef:
            name: hellok8s-config
```

Apply this updated manifest to update the Deployment.

### Verifying the Changes

After applying the changes, verify that the application is still working fine by accessing the service:

```bash
curl localhost:30001
# Output: [v4] It works with a ConfigMap! (from hellok8s-54d5fb5765-nl62z)
```

## Getting All the Variables from a ConfigMap

While the above approach works well for a single variable, it can become cumbersome when dealing with multiple variables. Kubernetes provides a convenient way to inject all variables from a ConfigMap into a container:

```yaml
# hellok8s.yaml
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
    spec:
      containers:
      - name: hellok8s
        image: <image_name>
        ports:
        - containerPort: 4567
        envFrom:
        - configMapRef:
            name: hellok8s-config
```

With this approach, all keys from the ConfigMap will be injected as environment variables into the container.

By leveraging ConfigMaps, we can efficiently manage configurations for our applications in Kubernetes, making them more flexible and easier to maintain.

Stay tuned as we explore more Kubernetes concepts!

# Adding Prefix to Environment Variables from ConfigMap

When using `envFrom` to import all values from a ConfigMap into a container's environment variables, Kubernetes automatically assigns the same names as defined in the ConfigMap. However, this approach may lead to conflicts if multiple ConfigMaps are used, as variables with the same name would be overridden. To mitigate this issue, Kubernetes allows adding a prefix to the imported variable names from each ConfigMap.

## Adding Prefix

Let's consider the following scenario where we want to add a prefix "CONFIG_" to all variable names imported from the `hellok8s-config` ConfigMap:

```yaml
# Deployment manifest with prefix added
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
      - image: brianstorti/hellok8s:v4
        name: hellok8s-container
        envFrom:
        - configMapRef:
            name: hellok8s-config
          prefix: CONFIG_
```

With this modification, all variables imported from the `hellok8s-config` ConfigMap will have the "CONFIG_" prefix appended to their names. For example, the variable "MESSAGE" from the ConfigMap will be injected as "CONFIG_MESSAGE" in the container's environment.

This approach ensures that variable names remain unique and prevents conflicts when using multiple ConfigMaps to configure applications in Kubernetes.
```

This README explains how to add a prefix to environment variables imported from a ConfigMap in Kubernetes to avoid conflicts when using multiple ConfigMaps. It provides a clear example and demonstrates how the prefix ensures uniqueness of variable names in the container's environment.