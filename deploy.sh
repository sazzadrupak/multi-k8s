docker build -t rupak08012/multi-client:latest -t rupak08012/multi-client:$SHA -f ./front/Dockerfile ./front
docker build -t rupak08012/multi-server:latest -t rupak08012/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rupak08012/multi-worker:latest -t rupak08012/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rupak08012/multi-client:latest
docker push rupak08012/multi-worker:latest
docker push rupak08012/multi-server:latest

docker push rupak08012/multi-client:$SHA
docker push rupak08012/multi-worker:$SHA
docker push rupak08012/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rupak08012/multi-server:$SHA
kubectl set image deployments/client-deployment client=rupak08012/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rupak08012/multi-worker:$SHA