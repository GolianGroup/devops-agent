FROM builder-base

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ARG MINICONDA_VERSION=4.12.0
ENV MINICONDA_VERSION $MINICONDA_VERSION
ARG PYTHON_VERSION=3.12
ENV PYTHON_VERSION $PYTHON_VERSION

# Install necessary tools and libraries
RUN dnf -y install epel-release dnf-plugins-core && \
    dnf config-manager --set-enabled powertools && \
    dnf clean all && \
    dnf -y groupinstall "Development Tools" && \
    dnf -y install nc openssl-devel bzip2 bzip2-devel libffi-devel zlib-devel xz-devel glibc-devel \
    openblas-devel lcms2-devel openjpeg2-devel libcurl-devel curl sqlite-devel \
    postgresql-devel gcc libffi-devel freetype-devel libpng-devel libjpeg-devel \
    zlib-devel glibc-locale-source glibc-langpack-en libtiff-devel tk-devel tcl-devel libxslt-devel git ncurses-devel gdbm-devel readline-devel && \
    dnf clean all

# Generate locale
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8

# Install Miniconda
RUN ARCH= && uArch="$(uname -m)" \
    && case "${uArch##*-}" in \
    x86_64) ARCH='x86_64';; \
    aarch64) ARCH='aarch64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
    esac \
    && MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py310_$MINICONDA_VERSION-Linux-${ARCH}.sh" \
    && wget --quiet $MINICONDA_URL -O ~/miniconda.sh \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p /opt/miniconda \
    && rm ~/miniconda.sh
ENV PATH /opt/miniconda/bin:$PATH

# Create a Python virtual environment
RUN conda create -n py3 python=$PYTHON_VERSION && \
    conda clean -ya

# Activate the virtual environment
RUN echo "conda activate py3" >> ~/.bashrc
ENV PATH /opt/miniconda/envs/py3/bin:$PATH

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

CMD ["python3", "--version"]
