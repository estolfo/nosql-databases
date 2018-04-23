#!/usr/bin/env bash

function install_rvm_and_ruby() {
  su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
  su - vagrant -c "curl -sSL https://get.rvm.io | bash -s $1"
  source $HOME/.rvm/scripts/rvm
  su - vagrant -c "rvm install ruby-2.5.0"
}

function install_mongodb() {
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
  apt-get update
  apt-get install -y mongodb-org
}

function setup_mongodb() {
  mkdir -p /data/db
  sudo chmod a+rw /data/db
}

function install_nodejs() {
  curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
  apt-get install -y nodejs
}

function setup_python {
  apt-get update
  apt-get install -y python-pip
  apt-get install -y python3-pip
}

install_nodejs
install_rvm_and_ruby
setup_python
install_mongodb
setup_mongodb
