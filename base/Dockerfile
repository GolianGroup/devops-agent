FROM centos:7

# Install utils
RUN yum install -y epel-release ca-certificates unzip which make wget zip bzip2 gcc gcc-c++ curl-devel autoconf expat-devel gettext-devel openssl-devel perl-devel zlib-devel python-pip && \
  yum -y clean all --enablerepo='*'

# Add Amazon Corretto repository
RUN rpm --import https://yum.corretto.aws/corretto.key && \
  curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo

# Install Amazon Corretto 17
RUN yum install -y java-17-amazon-corretto-devel && \
  yum -y clean all --enablerepo='*'

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto

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

# Copy Kaniko executor binary from the official Kaniko image
COPY --from=gcr.io/kaniko-project/executor:latest /kaniko/executor /usr/local/bin/kaniko
# Set the PATH environment variable to include Kaniko
ENV PATH=$PATH:/usr/local/bin

COPY ./ ./
RUN ./hack/install_utils.sh && rm -rf ./*

CMD ["docker","version"]
