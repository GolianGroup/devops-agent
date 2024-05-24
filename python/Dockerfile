FROM builder-base

# Set locale environment variables
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ARG MINICONDA_VERSION=4.12.0
ENV MINICONDA_VERSION $MINICONDA_VERSION
ARG PYTHON_VERSION=3.12
ENV PYTHON_VERSION $PYTHON_VERSION

# Install necessary tools and libraries
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y software-properties-common build-essential ncurses-dev libncursesw5-dev libreadline-dev \
    libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev \
    liblzma-dev libblas-dev liblapack-dev libjpeg-dev libpng-dev libtiff-dev libopenjp2-7-dev \
    liblcms2-dev libcurl4-openssl-dev curl libpq-dev git locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Generate locale
RUN locale-gen en_US.UTF-8

# Install Miniconda
RUN ARCH="$(uname -m)" && \
    case "${ARCH}" in \
    x86_64) ARCH='x86_64';; \
    aarch64) ARCH='aarch64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
    esac && \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py310_$MINICONDA_VERSION-Linux-${ARCH}.sh" && \
    wget --quiet $MINICONDA_URL -O ~/miniconda.sh && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/miniconda && \
    rm ~/miniconda.sh
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
