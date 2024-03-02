# Scheduling Jobs with CronJob in Kubernetes

In this chapter, we'll learn how to schedule Jobs using CronJob in Kubernetes.

## CronJob

### Example
A CronJob is a high-level resource in Kubernetes that allows us to schedule Jobs to run at specific intervals, similar to cron jobs in Unix-like operating systems. Let's explore an example:

```yaml
# echo-cronjob.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: echo-cronjob
spec:
  schedule: "* * * * *" # Every minute
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: echo
            image: alpine
            command: ["echo", "Hello, Kubernetes!"]
```

- This YAML manifest creates a CronJob named `echo-cronjob` that runs every minute, executing a Job with a single container that echoes "Hello, Kubernetes!".

### Understanding the `schedule` Property
The `schedule` property in the CronJob manifest specifies the time intervals at which the Job should be executed. It follows the crontab format, allowing for precise scheduling of Jobs.

## Testing the CronJob

### Applying the Manifest
To apply the CronJob manifest and schedule the Job, run the following command:

```bash
kubectl apply -f echo-cronjob.yaml
```

### Monitoring the Jobs
After applying the CronJob, no Jobs are immediately created. However, after one minute, Kubernetes creates a new Job based on the schedule defined in the CronJob. To monitor the Jobs, execute the following commands:

```bash
kubectl get jobs
# No resources found.

# Wait for one minute

kubectl get jobs
# NAME                      DESIRED   SUCCESSFUL
# echo-cronjob-1554109380   1         1
```

- This command retrieves the Jobs created by the CronJob. Initially, no Jobs are found, but after one minute, a new Job is created and successfully completes its execution.

## Conclusion
CronJobs in Kubernetes provide a powerful mechanism for scheduling Jobs to run at specific intervals. By defining the schedule property in the CronJob manifest, we can ensure that Jobs are executed automatically and efficiently according to our requirements.
```

This README provides guidance on scheduling Jobs using CronJob in Kubernetes. It explains how to define a CronJob manifest with a specific schedule and demonstrates how Kubernetes automatically creates and manages Jobs based on the defined schedule.