set -e
# minikube addons disable ingress
minikube stop
sleep 3
minikube delete

