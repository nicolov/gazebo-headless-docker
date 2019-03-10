# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM ubuntu:bionic

#
# ROS
# from https://github.com/osrf/docker_images/blob/eaca344ae304c30254451da89bae328eb65ee385/ros/melodic/ubuntu/bionic/ros-core/Dockerfile

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && apt-get install -q -y tzdata && rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
ENV ROS_DISTRO melodic
RUN apt-get update && apt-get install -y \
	ros-melodic-desktop \
    && rm -rf /var/lib/apt/lists/*

#
# Other things for ROS

RUN apt-get update && apt-get install -q -y \
	ninja-build python-pip python-dev python-wstool \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U \
    catkin-tools \
    jinja2

#
# Gazebo
# from https://github.com/osrf/docker_images/blob/e1b8c1ff5713777250ce44c7558c394a02c4f72a/gazebo/9/ubuntu/bionic/gzserver9/Dockerfile

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# setup sources.list
RUN . /etc/os-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-latest.list

# install gazebo packages
RUN apt-get update && apt-get install -q -y \
    gazebo9 libgazebo9-dev \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

# setup environment
EXPOSE 11345

#
# CPU rendering with LLVMPipe
# from https://www.openrobots.org/morse/doc/stable/headless.html


RUN apt-get update && apt-get install -q -y \
	llvm-dev scons python-mako libedit-dev flex wget bison \
    && rm -rf /var/lib/apt/lists/*

COPY ./scripts/build-mesa.sh /tmp

RUN /tmp/build-mesa.sh && rm /tmp/build-mesa.sh

#
# Screen grabbing and misc stuff

RUN apt-get update && apt-get install -q -y \
	ffmpeg xvfb vim tmux htop xdotool rsync \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U \
    numpy toml

#
#

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
