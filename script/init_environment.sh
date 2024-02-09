#!/bin/bash

# Update packages database and upgrade the system
pacman -Syu --noconfirm

# Install essential packages
pacman -S --noconfirm git

# Conditionally install openssh if SSH_PRIVATE_KEY is set
if [[ -n "${SSH_PRIVATE_KEY}" ]]; then
  pacman -S --noconfirm openssh
fi

# Install Ruby
pacman -S --noconfirm ruby

# Ensure gem is up to date
gem update --system

# Uninstall any existing versions of bundler
gem uninstall bundler -a -x || true

# Install specific version of Bundler
gem install bundler -v 2.5.5

gem env

# Verify installations
ruby -v # Should show the version of Ruby installed. You aim for Ruby 3.0, but this will show the latest version installed via pacman.
bundle -v # Should show Bundler version 2.5.5

# This is a temporary workaround
# See https://github.com/actions/checkout/issues/766
git config --global --add safe.directory "*"
