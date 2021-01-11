# DevOps - A simple Docker Swarm application using node.js to run Video on Demand services

Download This [video](https://youtu.be/eXju5LkrYs4) with 4k resolution and then rename it with _**DolbyVision.mkv**_

![alt text](https://iili.io/KeSqCl.jpg)


## Install the program

1. Build Node js app in docker

```
docker build -t <app name> .
```

2.  running the services (but we want to run Docker swarm, so we do not need to do)
```
docker run -it -p 3000:8000 <app name>
```

## Run Docker Swarm

1. Create swarm services (in some case firewall was blocked by ubuntu, you must enable it first with "sudo ufw allow 2377")
```
docker swarm init --advertise-addr <ip>
```

2. Copy token to node os
3. Vertify node
```
docker node ls
```

4. create services
```
# for running in one node
docker service create --name <name> -p 3000:8000 <image-name>

or

# for running in global nodes (all nodes connected to the token)
docker service create --name <name> -p 3000:8000 --mode global <image-name>

or

# enter manually the desired number of nodes
docker service create --name <name> -p 3000:8000 --relplicas <n node> <image-name>
```

5. Check running aplication
```
docker ps
```
6. List of Services
```
docker service ls
```

7. List task of services
```
docker service ps <name>
```

8. Scale app services
```
docker service scale <name>=<n node>
```

9. Remove node app (optional)
```
docker node rm <name>
```

10. Remove service (optional)
```
docker service rm <name>
```

11. Turn off node (optional)
```
docker node update --availability drain <Node ID>
```

12. Turn on node (optional)
```
docker node update --availability active <Node ID>
```

## NGINX Load Balancing

![alt text](https://iili.io/KZdL42.jpg)

1. Prepare the Diretory
```
sudo mkdir -p /data/loadbalancer
```

2. Create load balancer setup file with name "default.conf"
```
sudo nano /data/loadbalancer/default.conf
```

3. Write load balancer "default.conf"
```
server {
   listen 8000;
   location / {
      proxy_pass http://backend;
   }
}
upstream backend {
   server <manager ip>:3000;
   server <worker-1 ip>:3000;
   server <worker-2 ip>:3000;
}
```

4. create new docker service for nginx load balancer
```
docker service create \
--name loadbalancer \
--mount type=bind,source=/data/loadbalancer,target=/etc/nginx/conf.d \
--publish 80:80 \
swarm-lb
```


