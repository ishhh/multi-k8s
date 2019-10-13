docker build -t silkin/multi-client:latest -t silkin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t silkin/multi-server:latest -t silkin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t silkin/multi-worker:latest -t silkin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push silkin/multi-client:latest
docker push silkin/multi-server:latest
docker push silkin/multi-worker:latest

docker push silkin/multi-client:$SHA
docker push silkin/multi-server:$SHA
docker push silkin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=silkin/multi-server:$SHA
kubectl set image deployments/client-deployment client=silkin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=silkin/multi-worker :$SHA