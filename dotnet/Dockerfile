FROM registry.uk.glss.ir/kubesphere/builder-base:v0.0.1

RUN yum install -y krb5-libs gcc libicu openssl-libs compat-openssl10 libgdiplus

# Download and install the newer version of libstdc++
RUN cd /usr/local/lib64 && \
    wget http://www.vuln.cn/wp-content/uploads/2019/08/libstdc.so_.6.0.26.zip && \
    unzip libstdc.so_.6.0.26.zip && \
    cp libstdc++.so.6.0.26 /usr/lib64 && \
    cd /usr/lib64 && \
    rm -f libstdc++.so.6 && \
    ln -s libstdc++.so.6.0.26 libstdc++.so.6

# Download and run the dotnet-install.sh script
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel 8.0 \
    && rm dotnet-install.sh

# Add .NET to PATH
ENV DOTNET_ROOT="/root/.dotnet"
ENV PATH="${PATH}:${DOTNET_ROOT}"

## Install sonarscanner
RUN dotnet tool install --global dotnet-sonarscanner

## Install report generator
RUN dotnet tool install --global dotnet-reportgenerator-globaltool --version 4.8.12

ENV PATH="${PATH}:/root/.dotnet/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/sonar-scanner-5.0.1.3006-linux/bin:/root/.nuget/tools:/root/.dotnet/tools"

CMD ["dotnet", "--version"]