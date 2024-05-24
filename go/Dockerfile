FROM builder-base

# Install development tools
RUN apt-get update && apt-get install -y build-essential && apt-get clean && rm -rf /var/lib/apt/lists/*

ARG GOLANG_VERSION=1.22.2
ENV GOLANG_VERSION $GOLANG_VERSION

# Install Go
RUN wget https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    rm go${GOLANG_VERSION}.linux-amd64.tar.gz

# Set environment variables
ENV PATH $PATH:/usr/local/go/bin
ENV GOROOT /usr/local/go
ENV GOPATH /home/jenkins/go
ENV PATH $PATH:$GOPATH/bin

# Copy only the necessary files for the install_utils.sh script
COPY ./hack/install_utils.sh /tmp/install_utils.sh
# Run the install script
RUN /tmp/install_utils.sh && rm -rf /tmp/install_utils.sh

# Create necessary Go workspace directories
RUN mkdir -p $GOPATH/bin && mkdir -p $GOPATH/src && mkdir -p $GOPATH/pkg

CMD ["go", "version"]
