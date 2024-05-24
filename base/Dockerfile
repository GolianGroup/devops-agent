FROM centos:8

USER root

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*.repo && \
  sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

RUN dnf update -y && \
  dnf install -y epel-release && \
  dnf install -y autoconf nc python3 python3-pip python3-devel python3-setuptools python3-wheel && \
  dnf install -y gcc gcc-c++ make wget curl unzip bzip2 openssl-devel expat-devel gettext-devel perl-devel zlib-devel && \
  dnf clean all

# Add Amazon Corretto repository
RUN rpm --import https://yum.corretto.aws/corretto.key && \
  curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo

# Install Amazon Corretto 17
RUN yum install -y java-17-amazon-corretto-devel && \
  yum -y clean all --enablerepo='*'

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto

# Install dependencies required for Git HTTPS support
RUN dnf install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel && \
  dnf clean all

RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz && \
  tar zxvf git-2.9.5.tar.gz --no-same-owner && \
  cd git-2.9.5 && \
  make configure && \
  ./configure prefix=/usr/local/git/ && \
  make && \
  make install && \
  mv /usr/local/git/bin/git /usr/bin/ && \
  cd ..&& \
  rm -rf git-2.9.5.tar.gz git-2.9.5 && \
  git version

# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# USER jenkins
WORKDIR /home/jenkins

RUN curl -o sonar_scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
  unzip sonar_scanner.zip && rm sonar_scanner.zip \
  && rm -rf sonar-scanner-5.0.1.3006-linux/jre && \
  sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /home/jenkins/sonar-scanner-5.0.1.3006-linux/bin/sonar-scanner && \
  mv /home/jenkins/sonar-scanner-5.0.1.3006-linux /usr/bin

ENV PATH $PATH:/usr/bin/sonar-scanner-5.0.1.3006-linux/bin

# Set the PATH environment variable to include Kaniko
ENV PATH=$PATH:/usr/local/bin

COPY ./ ./
RUN ./hack/install_utils.sh && rm -rf ./*

# Set the PATH environment variable to include Docker Buildx
ENV PATH=$PATH:/root/.docker/cli-plugins

CMD ["docker","version"]