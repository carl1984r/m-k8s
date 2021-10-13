docker build -t carl1984a0/m-client-0:latest -t carl1984a0/m-client-0:$SHA -f ./client/Dockerfile ./client
docker build -t carl1984a0/m-server-0:latest -t carl1984a0/m-server-0:$SHA -f ./server/Dockerfile ./server
docker build -t carl1984a0/m-worker-0:latest -t carl1984a0/m-worker-0:$SHA -f ./worker/Dockerfile ./worker


docker push carl1984a0/m-client-0:latest
docker push carl1984a0/m-server-0:latest
docker push carl1984a0/m-worker-0:latest
docker push carl1984a0/m-client-0:$SHA
docker push carl1984a0/m-server-0:$SHA
docker push carl1984a0/m-worker-0:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=carl1984a0/m-server-0:$SHA
kubectl set image deployments/client-deployment client=carl1984a0/m-client-0:$SHA
kubectl set image deployments/worker-deployment worker=carl1984a0/m-worker-0:$SHA
