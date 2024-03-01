# Performing a Rolling Update in Kubernetes Deployment

## Introduction
In this chapter, you learned how to perform a rolling update of an application deployed via a Kubernetes Deployment object. A rolling update allows you to update your application to a new version without causing downtime by gradually replacing instances of the old version with instances of the new version.

## Steps to Perform a Rolling Update
1. **Check Current Deployment Status**: Start by checking the current status of your deployment using the following command:

    ```bash
    kubectl get deployment qsk-deploy
    ```

    This command displays information about the deployment, including the number of available replicas.

2. **Update Deployment YAML**: Edit the Deployment YAML file (`rolling-update.yaml` in this case) and modify the image version or any other configurations that need to be updated.

3. **Apply Updated Configuration**: Apply the updated configuration to Kubernetes using the `kubectl apply` command:

    ```bash
    kubectl apply -f 3zerodowntime/rolling-update.yaml
    ```

    This command sends the updated configuration to Kubernetes, triggering the rolling update process.

4. **Monitor Rolling Update Progress**: Monitor the progress of the rolling update using the `kubectl rollout status` command:

    ```bash
    kubectl rollout status deployment qsk-deploy
    ```

    This command displays the status of the rolling update, showing the progress of updating replicas to the new version.

5. **Verify Update Completion**: Once the rolling update is complete, verify that the deployment has been successfully updated:

    ```bash
    kubectl get deployment qsk-deploy
    ```

    This command should show that the deployment is up-to-date with the desired number of replicas.

## Observations
- Kubernetes performs a rolling update by gradually replacing old replicas with new ones, ensuring that the application remains available throughout the update process.
- The rolling update strategy can be customized using different parameters in the Deployment YAML file, such as `maxUnavailable` and `maxSurge`.

## Additional Notes
- Rolling updates are a key feature of Kubernetes deployments, allowing for seamless updates without downtime.
- It's important to test rolling updates in a staging environment before applying them to production to ensure compatibility and minimize disruptions.

## Next Steps
- Experiment with different rolling update strategies and parameters to understand their impact on application availability and performance.
- Explore other advanced deployment strategies in Kubernetes, such as blue-green deployments and canary releases, to further optimize application updates.

