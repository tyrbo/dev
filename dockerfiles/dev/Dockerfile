FROM tyrbo/base

RUN groupadd -g 1000 dev && useradd -u 1000 -g 1000 -m dev
RUN gpasswd -a dev docker

USER dev
WORKDIR /home/dev

# Install nodenv to manage node versions
RUN git clone https://github.com/nodenv/nodenv.git ~/.nodenv
RUN cd ~/.nodenv && src/configure && make -C src
RUN echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(nodenv init -)"' >> ~/.bashrc
RUN git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

# Install rbenv to manage ruby versions
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install vim-plug
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install dotfiles
ENV DOTFILE_VERSION 0.0.2
RUN git clone https://github.com/tyrbo/dotfiles.git --branch $DOTFILE_VERSION --depth 1 ~/.config/dotfiles
RUN cd ~/.config/dotfiles && ./install

ENV NODE_VERSION 6.9.1
ENV RUBY_VERSION 2.3.3

# Install neovim plugins
RUN bash -c "nvim --headless +PlugInstall +qall"

COPY entrypoint.sh /home/dev/entrypoint.sh

ENTRYPOINT ["/home/dev/entrypoint.sh"]
CMD ["bash"]
