FROM jenkins/jenkins:lts-jdk21

USER root

RUN apt-get update && \
    apt-get install -y git docker.io && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 999 docker \
  && usermod -aG docker jenkins

USER jenkins