#!/bin/sh

bundle exec rubocop --auto-correct

# Patch-level verification for Bundler
# update vulnerable gem with:
#   `bundle update --patch --conservative <vulnerable-gem-name>`
echo '##########################'
bundle audit check --update

echo '##########################'
bundle exec brakeman

echo '##########################'
bundle exec fasterer

echo '##########################'
bundle exec rails test
