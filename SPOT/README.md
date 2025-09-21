# Roboteam Dockers for SPOT
ros1 wrapper tested on ubuntu 22.

Docker files description:
- ros_noetic_ouster_LI_init: env for running ouster wrapper and FastLIO2(including lidar-imu calibration).
- ros_noetic_planner: main env for running exploration system algorithms, including planner, mapping, sensor fusion.
- ros_noetic_spot: env for running SPOT SDK API.
- ros_noetic_spot_sam2: same to above but allowing running sam2.

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
docker cp <container_name>:/<file_dir> <local_dir>
```

## Issues:
