# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set non-interactive mode for installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential tools and libraries
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    curl \
    libssl-dev \
    libffi-dev \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Configure system locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Copy the Spot SDK file to the container
COPY spot-sdk-4.0.3.tar.gz /spot-sdk/

# Extract the SDK file
RUN tar -xzf /spot-sdk/spot-sdk-4.0.3.tar.gz -C /spot-sdk/ \
    && rm /spot-sdk/spot-sdk-4.0.3.tar.gz

# Set the working directory to the Spot SDK directory
WORKDIR /spot-sdk/spot-sdk-4.0.3

# Install Python dependencies required for the Spot SDK
RUN pip3 install --upgrade pip setuptools wheel \
    && pip3 install -r python/requirements.txt

# Set the default command to open an interactive shell
CMD ["bash"]

