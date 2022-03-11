docker build -t meffowe24/multi-client:latest -t meffowe24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t meffowe24/multi-server:latest -t meffowe24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t meffowe24/multi-worker:latest -t meffowe24/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push meffowe24/multi-client:latest
docker push meffowe24/multi-server:latest
docker push meffowe24/multi-worker:latest

docker push meffowe24/multi-client:$SHA
docker push meffowe24/multi-server:$SHA
docker push meffowe24/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=meffowe24/multi-server:$SHA
kubectl set image deployments/client-deployment client=meffowe24/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=meffowe24/multi-worker:$SHA
