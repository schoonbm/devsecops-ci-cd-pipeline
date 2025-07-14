FROM eclipse-temurin:21-jdk

LABEL maintainer="Mirela"
LABEL description="Jenkins agent with Java 21, Maven, Trivy, Docker CLI, kubectl"

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        docker.io \
        unzip \
        lsb-release \
        ca-certificates \
        gnupg && \
    rm -rf /var/lib/apt/lists/*

# Install Maven
ENV MAVEN_VERSION=3.9.10
RUN curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | \
    tar -xz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn

# Install Trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Install kubectl
ENV KUBECTL_VERSION=v1.33.2
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Create workspace
WORKDIR /workspace

RUN groupadd -g 999 docker || true && \
    usermod -aG docker root