docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname

docker run -d --name kuard \
  --publish 8080:8080 \
  geewynn/kuad


docker run -d --name kuard \
  --publish 8080:8080 \
  --memory 200m \
  --memory-swap 1G \
  geewynn/kuad

7. Service discovery
kubectl create deployment alpaca-prod \
  --image=gcr.io/kuar-demo/kuard-amd64:blue \
  --port=8080
kubectl scale deployment alpaca-prod --replicas 3
kubectl expose deployment alpaca-prod
kubectl create deployment bandicoot-prod \
  --image=gcr.io/kuar-demo/kuard-amd64:green \
  --port=8080
kubectl scale deployment bandicoot-prod --replicas 2
kubectl expose deployment bandicoot-prod
kubectl get services -o wide

ALPACA_POD=$(kubectl get pods -l app=alpaca-prod \
    -o jsonpath='{.items[0].metadata.name}')
kubectl port-forward $ALPACA_POD 48858:8080
kubectl edit deployment/alpaca-prod

kubectl get endpoints alpaca-prod --watch
kubectl edit service alpaca-prod
kubectl describe service alpaca-prod

ssh <node> -L 8080:localhost:32711

kubectl describe endpoints alpaca-prod

kubectl get pods -o wide --show-labels
kubectl get pods -o wide --selector=app=alpaca

BANDICOOT_POD=$(kubectl get pods -l app=bandicoot \
    -o jsonpath='{.items[0].metadata.name}')
kubectl port-forward $BANDICOOT_POD 48858:8080