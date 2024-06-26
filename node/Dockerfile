FROM builder-base

ARG NODE_VERSION=18.20.2
ENV NODE_VERSION $NODE_VERSION

# Determine architecture and install Node.js
RUN uArch="$(uname -m)" \
  && case "${uArch}" in \
  x86_64) ARCH='x64';; \
  aarch64) ARCH='arm64';; \
  *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  # gpg keys listed at https://github.com/nodejs/node#release-keys
  && set -ex \
  && for key in \
  4ED778F539E3634C779C87C6D7062848A1AB005C \
  141F07595B7B3FFE74309A937405533BE57C7D57 \
  74F12602B6F1C4E913FAA37AD3A89613643B6201 \
  61FC681DFB92A079F1685E77973F295594EC4689 \
  8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
  C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  890C08DB8579162FEE0DF9DB8BEAB4DFCF555EF4 \
  C82FA3AE1CBEDC6BE46B9360C43CEC45C17AB93C \
  108F52B48DB57BB0CC439B2997B01419BD92F80A \
  ; do \
  gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key"; \
  done \
  && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && curl -fsSLO https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt \
  && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install necessary tools and libraries
RUN apt-get update && apt-get install -y \
  gcc g++ make bzip2 libgtk2.0-0 chromium-chromedriver xvfb \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm i -g watch-cli vsce typescript

# Yarn
ARG YARN_VERSION=1.16.0
ENV YARN_VERSION $YARN_VERSION
RUN curl -f -L -o /tmp/yarn.tgz https://github.com/yarnpkg/yarn/releases/download/v${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz && \
  tar xf /tmp/yarn.tgz && \
  mv yarn-v${YARN_VERSION} /opt/yarn && \
  ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn && \
  yarn config set cache-folder /root/.yarn
