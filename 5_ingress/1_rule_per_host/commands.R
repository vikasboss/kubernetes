kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/\
deploy/static/provider/cloud/deploy.yaml

kubectl apply -f hellok8s.yaml
# service/hellok8s-svc created
# deployment.apps/hellok8s created

kubectl apply -f nginx.yaml
# service/nginx-svc created
# deployment.apps/nginx created

kubectl apply -f ingress.yaml
# ingress.extensions/hello-ingress configured

# Please enter the following command if you get an error while applying the ingress 
# and then reapply the ingress using the above command
# If not, you can skip this command and move ahead
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

kubectl get ingress
# NAME           HOSTS             ADDRESS   PORTS
# hello-ingress  nginx.local.com   localhost 80
#                hello.local.com

# Check the status of the controller using the following commmand:
kubectl get pods --all-namespaces \
  -l app.kubernetes.io/name=ingress-nginx

# Please wait for the controller to run

# Inorder to run the ingress on the platform, you need to run the following port-forward command:
# You don't require this command if you're working locally

nohup kubectl port-forward --address 0.0.0.0 -n ingress-nginx service/ingress-nginx-controller 80:80 > /dev/null 2>&1 &

curl http://localhost
# 404...

curl --verbose http://localhost
# ...
# > GET / HTTP/1.1
# > Host: localhost
# > User-Agent: curl/7.54.0
# ...

curl --header 'Host: hello.local.com' localhost
# [v3] Hello, Kubernetes, from hellok8s-7f4c57d446-cjznh!

curl --header 'Host: nginx.local.com' localhost
# nginx welcome page

echo "127.0.0.1 hello.local.com" >> /etc/hosts
echo "127.0.0.1 nginx.local.com" >> /etc/hosts

curl http://hello.local.com
# [v3] Hello, Kubernetes, from hellok8s-7f4c57d446-qth54!

curl http://nginx.local.com
# nginx welcome page