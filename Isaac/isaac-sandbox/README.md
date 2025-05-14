# Docker for Roboteam Simulator
This is a collection of Dockerfiles and scripts to set up a development environment for the Roboteam Simulator. 

First, pull and build the base image for interactive isaac sim GUI

### Container Registry
This container is hosted on the GitLab Container Registry at `gitlab.cerlab.lan.cmu.edu:5050`.

#### Login to the Registry
Open a terminal and run the following command to log in to the GitLab Container Registry. You will need your GitLab username and password.

```bash
docker login gitlab.cerlab.lan.cmu.edu:5050
```
#### Pull docker image
To pull the docker image run 

```bash
docker pull gitlab.cerlab.lan.cmu.edu:5050/cerlab_public/isaac-sandbox
```


Our goal is to support interactive development, parameter tuning, and debugging, so we mount the source code as a volume in the container. This allows you to edit the code on your host machine and see the changes reflected in the container without needing to rebuild the image.