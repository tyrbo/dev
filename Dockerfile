FROM ubuntu:xenial

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV TERM xterm-256color

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

WORKDIR /tmp
RUN curl -fLo tmux-2.2.tar.gz https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz && \
  tar -xzvf tmux-2.2.tar.gz && \
  cd tmux-2.2 && \
  ./configure && \
  make && \
  make install

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd dev && useradd -m -g dev dev

USER dev
WORKDIR /home/dev

RUN git clone https://github.com/nodenv/nodenv.git ~/.nodenv
RUN cd ~/.nodenv && src/configure && make -C src
RUN echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(nodenv init -)"' >> ~/.bashrc

RUN git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
RUN ~/.nodenv/bin/nodenv install 6.9.1 && ~/.nodenv/bin/nodenv global 6.9.1

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN ~/.rbenv/bin/rbenv install 2.3.3 && ~/.rbenv/bin/rbenv global 2.3.3

RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN git clone https://github.com/tyrbo/dotfiles.git ~/.config/dotfiles
RUN cd ~/.config/dotfiles && ./install

RUN bash -c "nvim --headless +PlugInstall +qall"

CMD ["bash"]
