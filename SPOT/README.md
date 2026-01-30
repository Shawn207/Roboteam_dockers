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

Launch the containers by docker compose:
```
xhost + # enalbe X11 forwarding
sudo docker compose up

```

Re-enter the container in interactive mode
```
docker exec -it container_name bash
```

Select services combinations as you want in compose.yaml

if you want to stop:
```
sudo docker compose down
```

Send file form docker to local
```
docker cp <container_name>:/<file_dir> <local_dir>
```

If you want to run vscode ros debug mode in planner service container:

1. Make sure gdb is installed (latest version of Dockerfile.ros_noetic_planner).

2. Use dev container extension to attach into the running planner container. Choose the folder as the top level of your ros workspace.

3. Create appropriate launch.json. An example is here:
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "ROS 1: Launch File Debug",
            "type": "ros",
            "request": "launch",
            "target": "/root/home/catkin_ws/src/autonomous_robot/launch/ma_exploration_heter.launch",
            // Ensure the debugger path and mode are explicit so the project system
            // can determine which debugger to use inside the container.
            "MIMode": "gdb",
            "miDebuggerPath": "/usr/bin/gdb",
            // If you're using Remote - Containers, the debugger must exist in the
            // container at the path above. If you debug remotely with gdbserver,
            // set up `miDebuggerServerAddress` accordingly.
            // "miDebuggerServerAddress": "localhost:1234",
            "cwd": "${workspaceFolder}"
        }

    ]
}
```

## Issues:
