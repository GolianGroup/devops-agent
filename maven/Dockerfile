FROM builder-base

ARG JDK_VERSION=17
ENV JDK_VERSION $JDK_VERSION
ARG JDK_HOME=/usr/lib/jvm/java-${JDK_VERSION}-openjdk
ENV JDK_HOME $JDK_HOME
ENV JAVA_VERSION $JDK_VERSION
ARG MAVEN_VERSION=3.5.3
ENV MAVEN_VERSION $MAVEN_VERSION
ARG ANT_VERSION=1.10.7
ENV ANT_VERSION $ANT_VERSION

# Install dependencies
RUN apt-get update && apt-get install -y wget curl tar

# Install Java
RUN apt-get update && apt-get install -y openjdk-${JAVA_VERSION}-jdk

# Install Maven
RUN curl -f -L https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -C /opt -xzv
ENV M2_HOME /opt/apache-maven-$MAVEN_VERSION
ENV JAVA_HOME $JDK_HOME
ENV maven.home $M2_HOME
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH:$JAVA_HOME/bin

# Install Ant
RUN cd && \
  wget -q https://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
  tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
  mv apache-ant-${ANT_VERSION} /opt/ant && \
  rm apache-ant-${ANT_VERSION}-bin.tar.gz
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

CMD ["mvn","-version"]
