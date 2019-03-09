Record gazebo videos in the cloud
=================================

[![CircleCI](https://circleci.com/gh/nicolov/gazebo-headless-docker.svg?style=svg)](https://circleci.com/gh/nicolov/gazebo-headless-docker)

<img src="https://github.com/nicolov/gazebo-headless-docker/raw/master/screenshot.png" width="500" style="text-align: center"/>

[Gazebo](http://gazebosim.org/) is a useful tool for simulating robotic systems,
but it needs a GPU to run, which is inconvenient (read: expensive) to set up
in the cloud for automatic testing.

This repo uses [LLVMpipe](https://www.mesa3d.org/llvmpipe.html), a
software OpenGL renderer that allows Gazebo to run without a GPU. `scripts/run-demo.sh`
is a demo script that records the screen output from a simple Gazebo session.

For information about usage, follow the CI configuration in `.circleci/config.yml`.
