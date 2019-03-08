set -e
minikube start
certpath=certs/mdfinder.club
sleep 3
kubectl create secret tls https --cert $certpath/fullchain1.pem --key $certpath/privkey1.pem
kubectl create secret tls grpc --cert $certpath/fullchain1.pem --key $certpath/privkey1.pem
sleep 3
kubectl create -f dgraph.yaml 
sleep 3
# kubectl create -f imgproxy.yaml
# sleep 3
kubectl create configmap redis-config --from-file=./redis.conf
sleep 3
kubectl create -f redis.yaml
sleep 3
kubectl create -f ratel.yaml
sleep 3
kubectl create -f server.yaml
sleep 3
kubectl create -f matcher.yaml
sleep 3
kubectl create -f web.yaml
sleep 3
kubectl create -f ingress.yaml
echo 'dont forget: minikube addons enable ingress'
vboxmanage controlvm "minikube" natpf1 "mini0,tcp,0.0.0.0,1443,,443"
# echo 'now configuring vboxmanager'
# echo 'matcher: 30000, server: 30001, ratel: 30002, web: 30003, imgproxy: 30004'
# vboxmanage controlvm "minikube" natpf1 "mini0,tcp,0.0.0.0,30000,,30000"
# vboxmanage controlvm "minikube" natpf1 "mini1,tcp,0.0.0.0,30001,,30001"
# vboxmanage controlvm "minikube" natpf1 "mini2,tcp,0.0.0.0,30002,,30002"
# vboxmanage controlvm "minikube" natpf1 "mini3,tcp,0.0.0.0,30003,,30003"
# vboxmanage controlvm "minikube" natpf1 "mini4,tcp,0.0.0.0,30004,,30004"
# echo 'to deletee: vboxmanage controlvm "minikube" natpf1 delete https'
# echo 'to see info: vboxmanage showvminfo minikube'