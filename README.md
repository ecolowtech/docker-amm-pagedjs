docker build -t docker-amm-pagedjs .

docker tag docker-amm-pagedjs ecolowtech/docker-amm-pagedjs:latest
docker tag docker-amm-pagedjs ecolowtech/docker-amm-pagedjs:0.0.6

docker login

docker push ecolowtech/docker-amm-pagedjs:latest
docker push ecolowtech/docker-amm-pagedjs:0.0.6
