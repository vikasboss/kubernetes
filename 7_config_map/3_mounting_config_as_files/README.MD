# Exposing ConfigMap as Files

In Kubernetes, instead of injecting a ConfigMap's data directly into environment variables, we can expose the ConfigMap as files that are mounted into containers. This approach is beneficial when dealing with configuration files, such as nginx.conf, that need to be placed in specific locations within the container filesystem.

## Manifest Example

Here's an example manifest that demonstrates how to mount a ConfigMap's data as files in a container:

```yaml
# Deployment manifest with ConfigMap mounted as files
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
      volumes:
      - name: config
        configMap:
          name: hellok8s-config
      containers:
      - image: your_image_name:your_image_tag
        name: hellok8s-container
        volumeMounts:
        - name: config
          mountPath: /config
```

In this manifest:
- We define a volume named "config" and specify the ConfigMap "hellok8s-config" as the source.
- The volume is mounted into the container at the path "/config".

## Testing the Application

After applying the deployment and ConfigMap manifests, we can test the application to ensure that the ConfigMap's data is correctly exposed as files in the container:

```bash
kubectl apply -f hellok8s.yaml
kubectl apply -f hellok8s-config.yaml

kubectl get pods
# NAME                       READY   STATUS
# hellok8s-8c56675c9-7gxpv   1/1     Running
# hellok8s-8c56675c9-bfk8t   1/1     Running

# Replace the pod name with the actual pod name
kubectl exec -it hellok8s-8c56675c9-7gxpv -- sh

cat /config/MESSAGE
# It works with a ConfigMap!
```

This approach allows us to manage configurations more flexibly within Kubernetes by mounting ConfigMap data directly as files into containers.
```

This README provides an overview of how to expose a ConfigMap's data as files within Kubernetes containers, along with a detailed example manifest and instructions for testing the application.