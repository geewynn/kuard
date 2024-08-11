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


10. 

kubectl create -f kuard-deployment.yaml

kubectl get deployments kuard \
  -o jsonpath --template {.spec.selector.matchLabels}

kubectl get replicasets --selector=run=kuard

kubectl scale deployments kuard --replicas=2

kubectl scale replicasets kuard-1128242161 --replicas=1

kubectl get deployments kuard -o yaml > kuard-deployment.yaml
kubectl replace -f kuard-deployment.yaml --save-config

kubectl describe deployments kuard

kubectl rollout status deployments kuard

kubectl get replicasets -o wide

kubectl rollout pause deployments kuard

kubectl rollout resume deployments kuard

kubectl rollout history deployment kuard

kubectl rollout history deployment kuard --revision=2

kubectl rollout undo deployments kuard

kubectl rollout undo deployments kuard --to-revision=3

kubectl delete deployments kuard

kubectl delete -f kuard-deployment.yaml