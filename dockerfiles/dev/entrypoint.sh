#!/bin/bash

if [ ! -d "/home/dev/.rbenv/versions/$RUBY_VERSION" ]; then
  /home/dev/.rbenv/bin/rbenv install $RUBY_VERSION
fi

/home/dev/.rbenv/bin/rbenv global $RUBY_VERSION

if [ ! -d "/home/dev/.nodenv/versions/$NODE_VERSION" ]; then
  /home/dev/.nodenv/bin/nodenv install $NODE_VERSION
fi

/home/dev/.nodenv/bin/nodenv global $NODE_VERSION

$@
