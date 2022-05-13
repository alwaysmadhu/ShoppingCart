FROM ubuntu:18.04

MAINTAINER nagarjuna.madineedi@outlook.com

LABEL Trainer="Nagarjuna Madineedi"
LABEL Course="DevOps"

USER root
RUN apt-get update -y
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN useradd -s /bin/bash -d /home/nagarjuna/ -m -G sudo nagarjuna
RUN mkdir -p /home/nagarjuna/tomcat

WORKDIR /home/nagarjuna/tomcat

ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.78/bin/apache-tomcat-8.5.78.tar.gz /home/nagarjuna/tomcat

RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.78/* /home/nagarjuna/tomcat/
RUN apt-get -y install openjdk-8-jdk
RUN java -version
RUN rm -rf /home/nagarjuna/tomcat/apache-tomcat-8.5.78
RUN rm -rf /home/nagarjuna/tomcat/apache-tomcat-8.5.78.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

WORKDIR /home/nagarjuna/tomcat/webapps
COPY target/shopieasy.war /home/nagarjuna/tomcat/webapps

RUN chown nagarjuna:nagarjuna -R /home/nagarjuna/tomcat/
RUN chmod 755 -R /home/nagarjuna/tomcat/

EXPOSE 8080

USER nagarjuna
CMD ["/home/nagarjuna/tomcat/bin/catalina.sh", "run"]
