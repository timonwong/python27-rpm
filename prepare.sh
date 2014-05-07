#!/usr/bin/env bash

# Install ruby dependencies
yum -y install ruby rubygems ruby-devel
# Use taobao repo for ruby gems
gem sources -a http://ruby.taobao.org/
# Remove origin repo from ruby gems
gem sources --remove http://rubygems.org/
# Install fpm
gem install fpm

# Install build toolchain
yum -y groupinstall "Development tools"
yum -y install openssl-devel readline-devel bzip2-devel sqlite-devel zlib-devel ncurses-devel db4-devel expat-devel
