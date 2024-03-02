# Introduction to Secrets in Kubernetes

In Kubernetes, managing sensitive data such as credentials and private keys securely is essential. This is where Secrets come into play. In this chapter, we'll explore how Secrets are created and utilized within Kubernetes applications.

## Secrets Overview
Secrets in Kubernetes provide a secure way to store and distribute sensitive information to applications running in Kubernetes clusters. Unlike ConfigMaps, which are suitable for non-sensitive configuration data, Secrets are specifically designed for confidential information. Here are some key aspects of Secrets:

- **Secure Distribution**: Secrets are distributed only to the nodes running pods that require access to them, minimizing exposure to unauthorized entities.
- **Encryption**: Secrets are never written to physical storage. Instead, they are stored encrypted on the master node, enhancing security.
- **Base64 Encoding**: When accessed, Secrets return data encoded in base64. While this encoding doesn't provide encryption, it enables storage and retrieval of binary values within Secrets.

## Creating a Secret
Secrets are defined using YAML manifests similar to ConfigMaps. Here's how you can create a Secret:

```yaml
# hellok8s-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: hellok8s-secret
data:
  SECRET_MESSAGE: "SXQgd29ya3Mgd2l0aCBhIFNlY3JldAo="
```

Values within Secrets are base64 encoded to ensure security. You can encode values using tools like `echo` and `base64`.

## Injecting Secrets as Environment Variables
Secrets can be injected into containers as environment variables. Here's how you can inject a Secret into a deployment:

```yaml
# deployment.yaml
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
      - name: hellok8s-container
        image: hellok8s:v1
        env:
        - name: SECRET_MESSAGE
          valueFrom:
            secretKeyRef:
              name: hellok8s-secret
              key: SECRET_MESSAGE
```

This approach allows applications to access sensitive data securely through environment variables.

## Injecting Values from a Secret
Alternatively, all values from a Secret can be injected into containers without referencing specific keys. Here's how you can achieve this:

```yaml
# deployment.yaml
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
      - name: hellok8s-container
        image: hellok8s:v1
        envFrom:
        - secretRef:
            name: hellok8s-secret
```

This method simplifies the injection of multiple secrets into containers.

## Using `stringData`
To simplify the creation of Secrets, the `stringData` field can be used to define values in raw format. This eliminates the need to base64 encode values manually before creating a Secret.

By leveraging Secrets, Kubernetes users can manage sensitive information securely, ensuring that credentials and other confidential data are handled appropriately within their applications.
```bash
kubectl get secret hellok8s-secret -o yaml

# apiVersion: v1
# kind: Secret
# data:
#   SECRET_MESSAGE: SXQgd29ya3Mgd2l0aCBhIFNlY3JldAo=
# ...
```
```

This README provides a comprehensive overview of Secrets in Kubernetes, detailing their purpose, usage, and benefits for securely managing sensitive data within containerized applications.