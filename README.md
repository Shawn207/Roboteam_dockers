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
run spot docker:
```
docker run -it     --network=host     --privileged     -e DISPLAY=$DISPLAY     -v /tmp/.X11-unix:/tmp/.X11-unix     -v /home/cerlab/ros_noetic_docker_home/spot_ws/:/root/spot_ws/src spot_image:latest

```

if you want to stop:
```
sudo docker compose down
```

#Issues:
1. rviz cannot contact to master: I tried do a healthcheck on roscore service and set rviz depends on roscore health check. That hangs. Then I cancled it and redo, rviz works.
