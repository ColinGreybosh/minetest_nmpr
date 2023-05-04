# Minetest NMPR

A Dockerized version of the Minetest NMPR.

This version of the initial network multiplayer release of Minetest has been
modified to compile on modern GNU/Linux distributions, with Irrlicht 1.7 or 1.8,
and with JThread 1.2 or 1.3.

As the NMPR is rather minimalistic and it also has some historical significance,
it is useful for educational purposes.

## How to use

### Install Dependencies

Install [Docker Desktop](https://docs.docker.com/desktop/).

#### (MacOS) Install Additional Dependencies

```
$ brew install socat
$ brew install --cask xquartz
```

### Download and Build the Image

```
$ git clone https://github.com/ColinGreybosh/minetest_nmpr.git
$ cd minetest_nmpr
$ docker build -t minetest_nmpr .
```

### Set Up the Host Environment

#### MacOS

```
$ defaults write org.xquartz.X11 enable_iglx -bool true
$ xquartz
$ xhost +
```

In a seperate terminal, run:
```
$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

#### Linux
```
$ export DISPLAY=:0.0
$ xhost +local:docker
```

### Launch the Container

Add the `-p 30000:30000/tcp -p 30000:30000/udp` tags to the relevant command below if you would like to host a multiplayer session that clients can connect to on port 30000.

#### MacOS
```
$ docker run --privileged -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -p 30000:30000/tcp -p 30000:30000/udp minetest_nmpr
```

#### Linux
```
$ sudo docker run --privileged -it -e DISPLAY=$DISPLAY --network host -v /tmp/.X11-unix:/tmp/.X11-unix minetest_nmpr ../test
```
