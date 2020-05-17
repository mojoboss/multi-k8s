docker build -t mojomojomojo/multi-client:latest -t mojomojomojo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mojomojomojo/multi-server:latest -t mojomojomojo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mojomojomojo/multi-worker:latest -t mojomojomojo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mojomojomojo/multi-client:latest
docker push mojomojomojo/multi-server:latest
docker push mojomojomojo/multi-worker:latest

docker push mojomojomojo/multi-client:$SHA
docker push mojomojomojo/multi-server:$SHA
docker push mojomojomojo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mojomojomojo/multi-server:$SHA
kubectl set image deployments/client-deployment client=mojomojomojo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mojomojomojo/multi-worker:$SHA