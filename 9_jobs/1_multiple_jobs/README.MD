# Running Multiple Pods with Kubernetes Jobs

In this chapter, we'll explore how to run multiple instances of pods using Kubernetes Jobs. Specifically, we'll look at two approaches: using the `completions` field and the `parallelism` property.

## Using the `completions` Field

### Setting the `completions` Field
When we need to run a job more than once, we can set the `completions` field in the Job manifest to specify the desired number of completions.
```yaml
# echo-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: echo-job
spec:
  completions: 5
  template:
    spec:
      restartPolicy: OnFailure
      containers:
      - name: echo
        image: alpine
        command: ["echo", "Hello, Kubernetes!"]
```
- This YAML manifest defines a Job called `echo-job` with 5 completions, meaning it will run the specified task five times sequentially.

### Executing the Job
After applying the manifest, Kubernetes creates multiple pods sequentially, waiting for each to complete before starting the next one.
```bash
# Jobs are immutable, so delete it first if you already have one running.
kubectl delete job echo-job
# job.batch "echo-job" deleted

kubectl apply -f echo-job.yaml
# job.batch/echo-job created

# After a few seconds...
kubectl get pods
# NAME             READY   STATUS
# echo-job-b68j5   0/1     Completed
# echo-job-hcfnl   0/1     Completed
# echo-job-pdm6l   0/1     Completed
# echo-job-pjdcq   0/1     Completed
```
## Using the `parallelism` Property

### Setting the `parallelism` Property
To run multiple pods in parallel, we can use the `parallelism` property in the Job manifest.
```yaml
# echo-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: echo-job
spec:
  parallelism: 3
  completions: 5
  template:
    spec:
      restartPolicy: OnFailure
      containers:
      - name: echo
        image: alpine
        command: ["echo", "Hello, Kubernetes!"]
```
- This YAML manifest sets the `parallelism` property to 3, indicating that up to three pods can run simultaneously.

### Executing the Job with Parallelism
After applying the updated manifest, Kubernetes runs multiple pods concurrently, starting new pods as soon as others complete. This approach is useful for processing tasks in parallel, such as message processing or parallel computation.

## Conclusion
By leveraging the `completions` field and the `parallelism` property in Kubernetes Jobs, we can efficiently execute tasks across multiple pods, whether sequentially or in parallel. Understanding these options allows us to design job-based workflows that meet the specific requirements of our applications.
```

This README provides an overview of running multiple pods with Kubernetes Jobs, covering both sequential and parallel execution strategies using the `completions` field and the `parallelism` property. It demonstrates how to define Job manifests and execute them to achieve desired behavior in job-based workflows.