#!/usr/bin/env bash

function install_rvm_and_ruby() {
  su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
  su - vagrant -c "curl -sSL https://get.rvm.io | bash -s $1"
  source $HOME/.rvm/scripts/rvm
  su - vagrant -c "rvm install ruby-2.5.0"
  su - vagrant -c "gem install redis"
}

function install_nodejs() {
  curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
  apt-get install -y nodejs
}

function install_java_8() {
  add-apt-repository ppa:openjdk-r/ppa
  apt-get update
  apt-get install -y openjdk-8-jdk

  JAVA_PATH="$(which java)"
  chown -R vagrant:vagrant $JAVA_PATH
}

function install_redis() {
  apt-get update
  apt-get install -y redis-server
  apt-get install -y redis-tools

}

function setup_python {
  apt-get update
  apt-get install -y python-pip
}

install_nodejs
install_rvm_and_ruby
setup_python
install_redis

