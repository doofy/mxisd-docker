# Official docker image
The author released an improved docker image here:
https://github.com/kamax-io/mxisd/blob/master/Dockerfile

# My outdated docker image
This Dockerfile builds an small docker image for the
Matrix Identity Server Daemon mxisd https://github.com/kamax-io/mxisd.

The config dir of mxisd (/etc/mxis) gets mounted into the host filesystem (/data/mxisd).
There you have to put the config or mxisd will not run.

## Running a mxisd container using the Dockerfile
### Build the docker image from Dockerfile
docker build -t doofy/mxisd .

### Gather example config
https://raw.githubusercontent.com/kamax-io/mxisd/master/application.example.yaml

### Edit the example config to your liking
cp application.example.yaml application.yaml

### Place example config to mounted dir
mv application.yaml /data/mxisd/mxisd.yaml

### Use the image to create container
docker run -v /data/mxisd:/etc/mxis -p 8090:8090 --name mxisd doofy/mxisd

