#!/bin/sh

APP_USER_PASSWORD=app
MYSQL_PASSWORD=app


export DEBIAN_FRONTEND=noninteractive

echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list

apt-get update
apt-get upgrade

apt-get install -y \
  sudo \
  man-db \
  wget \
  git \
  nano \
  curl \
  dialog \
  net-tools \
  patch \
  gcc \
  libreadline6 \
  libreadline-dev \
  zlib1g \
  zlib1g-dev \
  libyaml-dev \
  openssl \
  make \
  bzip2 \
  autoconf \
  automake \
  libtool \
  bison \
  libxml2-dev \
  libxslt1.1 \
  libxslt1-dev \

# add 'app' group and user
addgroup app
useradd app -d /home/app -g app -m -p `$APP_USER_PASSWORD`

