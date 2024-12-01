# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Update and install essential tools
RUN apt-get update && apt-get install -y \
    locales \
    curl \
    gnupg2 \
    lsb-release \
    build-essential \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Setup sources for ROS Noetic
RUN curl -sSL http://packages.ros.org/ros.key | apt-key add - \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list'

# Install ROS Noetic Desktop Full and other necessary packages
RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    ros-noetic-catkin \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    python3-catkin-tools \
    ros-noetic-vision-msgs \
    python3-pip \
    git \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init && rosdep update

# Set up environment
SHELL ["/bin/bash", "-c"]
ENV ROS_PACKAGE_PATH=/opt/ros/noetic/share
ENV PATH=$PATH:/opt/ros/noetic/bin
RUN echo "export BOSDYN_CLIENT_USERNAME=user" >> ~/.bashrc \
    && echo "export BOSDYN_CLIENT_PASSWORD=scgau6g5w987" >> ~/.bashrc \
    && echo "export SPOT_HOSTNAME=\"192.168.80.3\"" >> ~/.bashrc \
    && echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Set working directory and copy workspace
WORKDIR /root/spot_ws
COPY ./spot_ws /root/spot_ws

# Clean any existing build or devel directories
RUN rm -rf /root/spot_ws/build /root/spot_ws/devel

# Build workspace
WORKDIR /root/spot_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /root/spot_ws/src/spot/src/spot/requirements.txt

# Set default command
CMD ["/bin/bash"]
