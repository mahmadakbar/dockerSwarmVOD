# DevOps - A simple Docker Swarm application using node.js to run Video on Deman services

Download This [video](https://youtu.be/eXju5LkrYs4) with 4k resolution and then rename it with _**DolbyVision.mkv**_

![alt text](https://iili.io/KeSqCl.jpg)

## Install the program

1. Build Node js app in docker

```
docker build -t <app name>
```

2.  running the services (but we want to run Docker swarm, so we do not need to do)
```
docker run -it -p 3000:8000 <app name>
```

## Run Docker Swarm

1. Create swarm service
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
docker service create <name> -p 3000:8000 <image-name>

or

# for running in global nodes (all nodes connected to the token)
docker service create <name> -p 3000:8000 --mode global <image-name>

or

# enter manually the desired number of nodes
docker service create <name> -p 3000:8000 --relplicas <n node> <image-name>
```

5. Check running aplication
```
docker ps
```
6. List of Service
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

10. Turn off node (optional)
```
docker node update - availability drain <Node ID>
```

10. Turn on node (optional)
```
docker node update - availability active <Node ID>
```
