FROM debian:jessie

MAINTAINER Michael Stypa <michael@stypa.info>

CMD ["/opt/mxisd/mxisd.jar", "--spring.config.location=/etc/mxis/", "--spring.config.name=mxisd"]
EXPOSE 8090
VOLUME ["/etc/mxis"]

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/sources.list
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get clean \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y -t jessie-backports \
    ca-certificates-java openjdk-8-jre-headless openjdk-8-jdk \
    bash tmux git wget curl htop
RUN git clone https://github.com/kamax-io/mxisd.git /mxisd
RUN cd /mxisd && ./gradlew build
RUN useradd -r mxisd
RUN mkdir -p /etc/mxis
RUN chown mxisd /etc/mxis
RUN mkdir /opt/mxisd
RUN cp /mxisd/build/libs/mxisd.jar /opt/mxisd/
RUN chmod a+x /opt/mxisd/mxisd.jar
RUN rm -rf /mxisd
