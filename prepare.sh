#!/usr/bin/env bash

# !NOTE! You have to run this script in sudo mode

# Change yum mirror
sed -i.backup 's/^enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base-aliyun.repo http://mirrors.aliyun.com/repo/Centos-6.repo
yum makecache
yum -y update
yum -y install wget

# Install EPEL repository
wget -P ~/ http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget -P ~/ http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh ~/remi-release-6*.rpm ~/epel-release-6*.rpm

# EPEL Mirror
mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup 2>/dev/null || :
mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup 2>/dev/null || :
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo

# Disable iptables
iptables -F

service iptables stop
chkconfig iptables off

# Install build toolchain
yum -y groupinstall "Development tools"
yum -y install openssl-devel readline-devel bzip2-devel sqlite-devel zlib-devel ncurses-devel db4-devel expat-devel

# Install ruby dependencies
yum -y install ruby rubygems ruby-devel
# Use taobao repo for ruby gems
gem sources -a http://ruby.taobao.org/
# Remove origin repo from ruby gems
gem sources --remove http://rubygems.org/
# Install fpm
gem install fpm -v 1.0.2
