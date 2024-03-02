# Handling Pod Failures in Kubernetes Jobs

In this chapter, we'll explore how to handle pod failures in Kubernetes Jobs and set the number of retries using the `backoffLimit` property.

## Using the `backoffLimit` Property

### Setting the `backoffLimit` Property
When a pod fails in a Job, Kubernetes retries running it based on an exponential back-off delay. By default, it retries up to six times. However, we can override this limit by setting the `backoffLimit` property in the Job manifest.
```yaml
# echo-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: echo-job
spec:
  backoffLimit: 10
  template:
    spec:
      restartPolicy: OnFailure
      containers:
      - name: echo
        image: alpine
        command: ["echo", "Hello, Kubernetes!"]
```
- This YAML manifest sets the `backoffLimit` property to 10, allowing the Job to retry running failed pods up to 10 times.

### Executing the Job
After applying the manifest, Kubernetes attempts to run the pod multiple times according to the specified `backoffLimit`.

## Testing the Job

### Observing Pod Restarts
To observe pod restarts, run the following commands:
```bash
kubectl apply -f echo-job.yaml
kubectl get pods --watch
```
- Watch the pods to see how many times they restart due to failures.

## Setting the `activeDeadlineSeconds` Property
Additionally, we can set the `activeDeadlineSeconds` property in the Job manifest to define a time limit for the Job's execution. After this duration, if all pods haven't finished successfully, the Job fails.
```yaml
# echo-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: echo-job
spec:
  backoffLimit: 10
  activeDeadlineSeconds: 3600 # 1 hour
  template:
    spec:
      restartPolicy: OnFailure
      containers:
      - name: echo
        image: alpine
        command: ["echo", "Hello, Kubernetes!"]
```
- This YAML snippet sets a time limit of 3600 seconds (1 hour) for the Job's execution.

## Conclusion
By using the `backoffLimit` property, we can control the number of retries for failed pods in Kubernetes Jobs, ensuring robustness in handling failures. Additionally, setting an `activeDeadlineSeconds` property defines a maximum duration for the Job's execution, preventing it from running indefinitely in case of persistent failures.
```

This README provides guidance on handling pod failures in Kubernetes Jobs using the `backoffLimit` property. It explains how to configure the number of retries for failed pods and set a time limit for Job execution using the `activeDeadlineSeconds` property.