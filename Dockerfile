# Start your image with a node base image
FROM ubuntu:latest

# The /app directory should act as the main application directory
WORKDIR /app

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y make
RUN apt-get install -y libirrlicht-dev
RUN apt-get install -y libjthread-dev
RUN apt-get install -y libx11-dev
RUN apt-get install -y libxext-dev
RUN apt-get install -y libxxf86vm-dev
RUN apt-get install -y freeglut3-dev
RUN apt-get install -y mesa-utils libgl1-mesa-glx
RUN apt-get install -y libgl1-mesa-dri
RUN apt-get install -y xserver-xorg-video-all
RUN apt-get install -y imagemagick

# Copy local directories to the current local directory of our docker image (/app)
COPY ./src ./src
COPY ./data ./data
COPY ./Makefile ./Makefile

RUN mkdir -p ./bin

RUN make

RUN cd data && mogrify *.png

# Save space on the image by removing dev dependencies
RUN apt-get remove -y build-essential
RUN apt-get remove -y make
RUN apt-get remove -y imagemagick

EXPOSE 3000

WORKDIR /app/bin

# Start the app
CMD [ "./test" ]
