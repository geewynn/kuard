curl -o kuard.crt  https://storage.googleapis.com/kuar-demo/kuard.crt
curl -o kuard.key https://storage.googleapis.com/kuar-demo/kuard.key

kubectl create secret generic kuard-tls \
  --from-file=kuard.crt \
  --from-file=kuard.key


kubectl describe secrets kuard-tls


kubectl create secret docker-registry my-image-pull-secret \
  --docker-username=<username> \
  --docker-password=<password> \
  --docker-email=<email-address>

kubectl get secrets

kubectl get configmaps

kubectl describe configmap my-config
