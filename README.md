# docker-ssr
docker-ssr
#安装docker
```
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

sudo usermod -aG docker username
```
#使用
```
docker container list
docker pull ghostry/ssr:latest

docker container stop gssr && docker container rm gssr && \
docker run --detach \
    --publish 9000-9002:9000-9002 \
    --name gssr \
    --restart always \
    --volume /data/shadowsocks:/etc/shadowsocks \
    ghostry/ssr:latest
```

#自己构建
```
git clone https://github.com/ghostry/docker-ssr.git
cd docker-ssr
docker build --no-cache -t ghostry/ssr:latest .
```

