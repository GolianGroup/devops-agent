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

# java
RUN if [ "x${JAVA_VERSION}" = "x17" ]; then \
    ARCH= && uArch="$(uname -m)" \
    && case "${uArch##*-}" in \
    x86_64) ARCH='x64';; \
    aarch64) ARCH='aarch64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
    esac \
    && wget https://download.oracle.com/java/${JAVA_VERSION}/latest/jdk-${JAVA_VERSION}_linux-${ARCH}_bin.rpm \
    && rpm -ivh jdk-${JAVA_VERSION}_linux-${ARCH}_bin.rpm; \
    else \
    yum install -y java-${JAVA_VERSION}-openjdk-devel java-${JAVA_VERSION}-openjdk-devel.i686; \
    fi

# gradle6
ENV PATH ${GRADLE_HOME}/bin:$PATH
ENV PATH $JAVA_HOME/bin:$PATH

RUN curl -fSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    echo "$(curl -sLf https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip.sha256) gradle.zip" | sha256sum --check && \
    unzip -q gradle.zip -d /usr/local && \
    rm -f gradle.zip

CMD ["gradle","--version"]
