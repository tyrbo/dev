#!/bin/bash

if [ ! -d "/home/dev/.rbenv/versions/$RUBY_VERSION" ]; then
  /home/dev/.rbenv/bin/rbenv install $RUBY_VERSION
fi

/home/dev/.rbenv/bin/rbenv global $RUBY_VERSION

$@
