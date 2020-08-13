
FROM ubuntu:18.04

MAINTAINER Andrey Mendelson "amenos@gmail.com"

RUN apt-get update
RUN apt-get -y install default-jdk
RUN apt-get -y install git
RUN git clone https://github.com/amenos99/boxfuse.git
RUN apt-get -y install docker.io
RUN apt-get -y install tomcat8
RUN apt-get -y install maven

RUN mvn package
RUN cp /boxfuse/target/hello-1.0.war /var/lib/tomcat8/webapps

EXPOSE 8080
RUN apt-get clean