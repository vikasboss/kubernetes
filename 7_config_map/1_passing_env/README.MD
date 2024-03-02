# Passing an Environment Variable to Our Container

## Creating a New Version

To demonstrate how to pass an environment variable to our container, let's create a new version (v4) of our hellok8s application. In this version, the displayed message will be determined by an environment variable.

### Updating the Service Configuration

First, we need to update the Service configuration to ensure everything is working fine:

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
```

Apply this manifest to create the Service.

### Updating the Deployment Configuration

Next, we update the Deployment configuration to include the environment variable `MESSAGE`:

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
    spec:
      containers:
      - name: hellok8s
        image: <image_name>
        ports:
        - containerPort: 4567
        env:
        - name: MESSAGE
          value: "It works!"
```

Apply this updated manifest to create the Deployment.

### Verifying the Changes

After applying the updated Deployment, verify that the changes are reflected by accessing the service:

```bash
curl localhost:30001
# Output: [v4] It works! (from hellok8s-568f64dd94-bfxhs)
```

Congratulations! You have successfully passed an environment variable to your container, and it is being utilized by your application.

Stay tuned as we continue to explore more advanced Kubernetes concepts.
```

This README provides step-by-step instructions on how to create a new version of the hellok8s application and pass an environment variable to the container. It includes updated Service and Deployment configurations, along with commands for verification.