# Roboteam Dockers for SPOT
run ros1 on ubuntu 22

## Instruction:
go to '''Roboteam_dockers/SPOT/'''

For the multi machine, close the ufw(Uncomplicated Firewall)
```
sudo ufw disable
```

build base docker image:
```
docker build -f dockerfile_name -t your_image_name:tag .
```

docker compose:
```
xhost + # enalbe X11 forwarding
sudo docker compose up

```

Re-enter the container
```
docker exec -it container_name bash
```


if you want to stop:
```
sudo docker compose down
```

Send file form docker to local
```
docekr cp <container_name>:/<file_dir> <local_dir>
```

## Issues:
