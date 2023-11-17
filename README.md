# docker-sdrtrunk

```sh
docker build -t sdrtrunk .
docker build -t sdrtrunk . --platform linux/x86_64
docker build -t sdrtrunk . -f Dockerfile.aarch64
docker build -t sdrtrunk . -f Dockerfile.aarch64 --platform linux/amd64

docker run -d \
  --name=sdrtrunk \
  --platform linux/x86_64 \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 3000:3000 \
  -p 3001:3001 \
  -v ./config:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  sdrtrunk

docker exec -it sdrtrunk /bin/bash

docker stop sdrtrunk
docker rm sdrtrunk
```
