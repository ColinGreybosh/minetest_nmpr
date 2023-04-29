# Start your image with a node base image
FROM ubuntu:latest

# The /app directory should act as the main application directory
WORKDIR /app

RUN apt-get update
RUN apt-get install -y build-essential make libirrlicht-dev libjthread-dev libx11-dev
RUN apt-get install -y libxext-dev
RUN apt-get install -y libxxf86vm-dev
RUN apt-get install -y freeglut3-dev
RUN apt-get install -y mesa-utils libgl1-mesa-glx
RUN apt-get install -y libgl1-mesa-dri

# Copy local directories to the current local directory of our docker image (/app)
COPY ./src ./src
COPY ./data ./data
COPY ./Makefile ./Makefile

RUN mkdir -p ./bin

RUN make

EXPOSE 3000

# Start the app
CMD [ "./bin/test" ]
