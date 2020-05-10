#!/bin/bash
rm -rf *.xcworkspace
rm -rf Podfile.lock
rm -rf Pods
bundle install
bundle exec pod install
open *.xcworkspace
