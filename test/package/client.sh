#!/usr/bin/env bash

set -ue

rm -f *.gem
rm -rf test/package/installed

echo "Building client gem"
gem build error_telemetry-client.gemspec --norc

echo "Installing client gem"
gem install error_telemetry-client*.gem \
  --install-dir ./test/package/installed \
  --norc \
  --no-document

export GEM_PATH=test/package/installed

ruby test/package/client.rb
