# ExternalName Service

Welcome to the ExternalName Service README! In this section, you'll learn about the ExternalName service type in Kubernetes and how it can be utilized. Below is an overview of the topics covered:

## Contents:

1. **Introduction to ExternalName**
    - Overview of the ExternalName service type.

## Introduction to ExternalName

The ExternalName service type in Kubernetes is unique as it is not used to provide a stable endpoint to an internal service within the cluster, but rather to an external resource or service outside of the cluster. 

For instance, consider a scenario where you have a database running at `my-db.company.com`. Instead of hardcoding or defining this endpoint in a configuration file, you can create an ExternalName service, like so:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  type: ExternalName
  externalName: my-db.company.com
```

With this setup, your pods can communicate with the `db` service without needing to know the actual address of the database. If the database moves to a different location, you only need to update the `externalName` field in the service configuration. Your pods remain unaffected by the change, as they continue to communicate with the `db` service.

