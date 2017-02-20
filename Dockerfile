FROM ubuntu:16.04
MAINTAINER pbohrer@me.com

# Install related packages and set LLVM 3.6 as the compiler
RUN apt-get -q update && \
    apt-get -q install -y \
    make \
    libc6-dev \
    clang-3.6 \
    curl \
    libedit-dev \
    python2.7 \
    python2.7-dev \
	openssl \
	libssl-dev \
    libicu-dev \
    rsync \
    libxml2 \
    git \
	vim \
    libcurl4-openssl-dev \
    && update-alternatives --quiet --install /usr/bin/clang clang /usr/bin/clang-3.6 100 \
    && update-alternatives --quiet --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100 \
    && rm -r /var/lib/apt/lists/*

# Everything up to here should cache nicely between Swift versions, assuming dev dependencies change little
ENV PATH=/usr/bin:$PATH

ADD .vim /root/.vim
ADD .vimrc /root/.vimrc
RUN echo "set -o vi" >> /root/.bashrc

COPY swift.tar.gz /tmp

RUN tar -xzf /tmp/swift.tar.gz --directory / --strip-components=1 \
    && rm -r /tmp/swift.tar.gz

# Print Installed Swift Version
RUN swift --version
