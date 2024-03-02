```markdown
# Defining Rules per Host

In this section, we'll explore how to serve services on different hosts using Ingress in Kubernetes.

## Table of Contents

- [Serving Services in Different Hosts](#serving-services-in-different-hosts)
- [Sending the Correct Host in Local Requests](#sending-the-correct-host-in-local-requests)

## Serving Services in Different Hosts

Instead of routing requests based solely on paths, we can configure Ingress to direct traffic to different hosts. For example, we may want to serve nginx at `nginx.example.com` and hellok8s at `hello.example.com`.

To achieve this, we need to define separate rules in the Ingress manifest, each specifying a `host` attribute. This tells Kubernetes to match requests only if they are sent to the specified host (as indicated by the Host header in the HTTP request).

```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
    - host: nginx.local.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-svc
                port:
                  number: 1234
```

## Sending the Correct Host in Local Requests

When testing locally, we need to ensure that our requests include the correct Host header. This can be achieved using tools like curl, where we can manipulate headers.

```bash
curl --header 'Host: hello.local.com' localhost
# [v3] Hello, Kubernetes, from hellok8s-7f4c57d446-cjznh!
```

Another approach is to configure the local DNS to resolve the desired hosts to localhost. This can be done by editing the `/etc/hosts` file (or `C:\windows\system32\drivers\etc\hosts` on Windows).

```bash
echo "127.0.0.1 hello.local.com" >> /etc/hosts
echo "127.0.0.1 nginx.local.com" >> /etc/hosts
```

With these configurations, we can access our services using the defined hosts, both in curl commands and in web browsers.

# Applying the Ingress Controller

```bash
kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/\
deploy/static/provider/cloud/deploy.yaml

kubectl apply -f hellok8s.yaml
kubectl apply -f nginx.yaml
kubectl apply -f ingress.yaml
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
```

Ensure the controller pods are running:

```bash
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx
```

To run the Ingress on the platform, execute the following port-forward command:

```bash
nohup kubectl port-forward --address 0.0.0.0 -n ingress-nginx service/ingress-nginx-controller 80:80 > /dev/null 2>&1 &
```

Test the configured hosts:

```bash
curl http://hello.local.com
curl http://nginx.local.com
```

These commands should return the expected responses from the respective services.
```

This readme provides guidance on defining rules per host using Ingress in Kubernetes, along with instructions for configuring local requests to match defined hosts and applying the Ingress Controller.