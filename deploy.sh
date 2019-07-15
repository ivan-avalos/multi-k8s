# Build!
docker build -t avalos/multi-client:latest -t avalos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t avalos/multi-server:latest -t avalos/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t avalos/multi-worker:latest -t avalos/multi-worker:$SHA -f ./client/Dockerfile ./worker

# Push!
docker push avalos/multi-client:latest
docker push avalos/multi-server:latest
docker push avalos/multi-worker:latest

docker push avalos/multi-client:$SHA
docker push avalos/multi-server:$SHA
docker push avalos/multi-worker:$SHA

# Apply!
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=avalos/multi-server:$SHA
kubectl set image deployments/client-deployment client=avalos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=avalos/multi-worker:$SHA
