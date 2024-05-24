FROM builder-base

ARG JDK_VERSION=17
ENV JDK_VERSION $JDK_VERSION
ARG JDK_HOME=/usr/lib/jvm/java-${JDK_VERSION}-openjdk
ENV JDK_HOME $JDK_HOME
ARG GRADLE_VERSION=6.9.1
ENV GRADLE_VERSION $GRADLE_VERSION
ARG GRADLE_HOME=/usr/local/gradle-${GRADLE_VERSION}
ENV GRADLE_HOME $GRADLE_HOME
ENV JAVA_VERSION $JDK_VERSION
ENV JAVA_HOME $JDK_HOME

# Install dependencies
RUN apt-get update && apt-get install -y wget curl unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Java
RUN apt-get update && apt-get install -y openjdk-${JAVA_VERSION}-jdk

# Set PATH for Gradle and Java
ENV PATH ${GRADLE_HOME}/bin:$JAVA_HOME/bin:$PATH

# Install Gradle
RUN curl -fSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    echo "$(curl -sLf https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip.sha256) gradle.zip" | sha256sum --check && \
    unzip -q gradle.zip -d /usr/local && \
    rm -f gradle.zip

CMD ["gradle","--version"]
