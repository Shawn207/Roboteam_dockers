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
    iputils-ping \
    net-tools \
    nano \
    vim \
    wget \
    python3-opencv \
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
    ros-noetic-geometry-msgs \
    ros-noetic-nav-msgs \
    ros-noetic-sensor-msgs \
    ros-noetic-cv-bridge \
    ros-noetic-pcl-ros \
    ros-noetic-pcl-conversions \
    python3-pip \
    git \
    libssl-dev \
    libffi-dev \
    libspdlog-dev \
    && rm -rf /var/lib/apt/lists/*
    
# Initialize rosdep
RUN rosdep init && rosdep update

# Set up environment
SHELL ["/bin/bash", "-c"]
ENV ROS_PACKAGE_PATH=/opt/ros/noetic/share
ENV PATH=$PATH:/opt/ros/noetic/bin

# Add environment variables for spot robot
RUN echo "export BOSDYN_CLIENT_USERNAME=user" >> ~/.bashrc \
    && echo "export BOSDYN_CLIENT_PASSWORD=scgau6g5w987" >> ~/.bashrc \
    && echo "export SPOT_HOSTNAME=\"192.168.80.3\"" >> ~/.bashrc \
    && echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Create catkin workspace and clone spot
RUN mkdir -p /root/spot_ws/src
WORKDIR /root/spot_ws/src
RUN git clone https://github.com/LibraJoy/spot.git

# Install Python dependencies
WORKDIR /root/spot_ws
RUN pip3 install --no-cache-dir -r /root/spot_ws/src/spot/src/spot/requirements.txt

RUN pip3 install --upgrade pip && \
    pip3 install --upgrade \
    numpy==1.24.4 \
    matplotlib==3.7.1 \
    Pillow==10.0.0 \
    requests==2.31.0 \
    protobuf==3.20.0 \
    ultralytics
# Install Dependencies
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    rosdep install --from-paths src --ignore-src -r -y"

# Source ROS and build workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make clean && catkin_make"

# Source the workspace setup in bashrc
RUN echo "source /root/spot_ws/devel/setup.bash" >> ~/.bashrc

# Set default command
CMD ["/bin/bash"]
