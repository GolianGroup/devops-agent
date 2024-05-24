# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install necessary packages
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y software-properties-common && \
  apt-add-repository universe && \
  apt-get update && \
  apt-get install -y autoconf git net-tools python3 python3-pip python3-venv python3-dev python3-setuptools python3-wheel && \
  apt-get install -y gcc g++ libcurl4-openssl-dev make wget curl unzip bzip2 libssl-dev libexpat1-dev gettext libperl-dev zlib1g-dev openjdk-17-jdk && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a virtual environment and install the latest version of the cryptography library
RUN python3 -m venv /opt/venv && \
  /opt/venv/bin/pip install --upgrade pip && \
  /opt/venv/bin/pip install cryptography

# Make sure the virtual environment binaries are in the PATH
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /home/jenkins

# Install Sonar Scanner
RUN curl -o sonar_scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
  unzip sonar_scanner.zip && rm sonar_scanner.zip && \
  rm -rf sonar-scanner-5.0.1.3006-linux/jre && \
  sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /home/jenkins/sonar-scanner-5.0.1.3006-linux/bin/sonar-scanner && \
  mv /home/jenkins/sonar-scanner-5.0.1.3006-linux /usr/bin

ENV PATH $PATH:/usr/bin/sonar-scanner-5.0.1.3006-linux/bin
ENV PATH=$PATH:/usr/local/bin
ENV PATH=$PATH:/root/.docker/cli-plugins

# Copy the installation script and run it
COPY ./hack/install_utils.sh /tmp/install_utils.sh
RUN /tmp/install_utils.sh && rm -rf /tmp/install_utils.sh

CMD ["docker", "version"]