# Roboteam Dockers for SPOT
run ros1 on ubuntu 22

## Instruction:

For the multi machine, close the ufw(Uncomplicated Firewall)
```
sudo ufw disable
```

build base docker image:
```
#docker build -t your_image_name:tag .
```

docker compose:
```
xhost + # enalbe X11 forwarding
sudo docker compose up

```

Re-enter the spot image
```
docker exec -it spot_image bash
```


if you want to stop:
```
sudo docker compose down
```

## Issues:
