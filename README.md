# Roboteam Dockers for SPOT
run ros1 on ubuntu 22

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

#Issues:
1. spot_image:both wifi and ethernet is woking. and compose of spot is done, but still need to write a shell for running estop_nogui.py in a new terminal.
