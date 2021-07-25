docker build -t docker-amm-pagedjs .

docker login

docker tag docker-amm-pagedjs ecolowtech/docker-amm-pagedjs:latest ecolowtech/docker-amm-pagedjs:0.0.1

docker push ecolowtech/docker-amm-pagedjs:latest
docker push ecolowtech/docker-amm-pagedjs:0.0.1
