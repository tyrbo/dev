FROM ubuntu:xenial

# Adds missing locale - tmux needed this
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Sets term to xterm-256color - needed for proper coloring in tmux.
ENV TERM xterm-256color

# Install everything we'll need for subsequent steps.
RUN apt-get update && apt-get install -y \
  python-software-properties \
  software-properties-common

RUN add-apt-repository -y ppa:neovim-ppa/unstable

RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  libevent-dev \
  libncurses-dev \
  libpq-dev \
  libreadline-dev \
  libssl-dev \
  git \
  ncurses-term \
  neovim \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \
  python3-setuptools \
  silversearcher-ag \
  xclip \
  zlib1g-dev

RUN pip3 install neovim

# Tmux (with truecolor)
WORKDIR /tmp
RUN curl -fLo tmux-2.2.tar.gz https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz && \
  tar -xzvf tmux-2.2.tar.gz && \
  cd tmux-2.2 && \
  ./configure && \
  make && \
  make install

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl https://get.docker.com/builds/Linux/x86_64/docker-1.12.5.tgz > docker.tgz
RUN tar xf docker.tgz && \
  mv docker/docker /usr/bin

RUN groupadd -g 999 docker

RUN curl -L https://github.com/docker/compose/releases/download/1.10.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

CMD ["bash"]
