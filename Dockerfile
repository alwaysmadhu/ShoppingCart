FROM ubuntu:18.04

USER root

RUN apt-get update -y
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN apt-get install vim -y
RUN apt-get install sudo -y
RUN apt-get install openjdk-8-jdk -y
RUN java -version

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

RUN useradd -s /bin/bash -d /home/madhu/ -m -G sudo madhu
RUN mkdir -p /home/madhu/tomcat

WORKDIR /home/madhu/tomcat

ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.78/bin/apache-tomcat-8.5.78.tar.gz .
RUN tar -zxvf apache*.tar.gz
RUN mv apache-tomcat-8.5.78/* /home/madhu/tomcat/
RUN rm -rf apache-tomcat-8.5.78
RUN rm -rf apache*.tar.gz

COPY ShopiEasy.war /home/madhu/tomcat/webapps

RUN chown -R madhu:madhu /home/madhu/tomcat/
RUN chmod -R 755 /home/madhu/tomcat/

EXPOSE 8080

USER madhu
CMD ["/home/madhu/tomcat/bin/catalina.sh", "run"]
