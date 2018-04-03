#!/usr/bin/env bash

function install_rvm_and_ruby() {
  su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
  su - vagrant -c "curl -sSL https://get.rvm.io | bash -s $1"
  source $HOME/.rvm/scripts/rvm
  su - vagrant -c "rvm install ruby-2.5.0"
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

function install_neo4j() {
  wget --no-check-certificate -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
  echo 'deb http://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
  apt-get update
  apt install -y neo4j
  chmod go+w /var/log/neo4j

  [ -d "/var/run/neo4j" ] || mkdir -p "/var/run/neo4j"
  [ -d "/var/lib/neo4j" ] || mkdir -p "/var/lib/neo4j"
  chown vagrant:vagrant /var/run/neo4j
}


function setup_python {
  apt-get update
  apt-get install -y python-pip
}

install_nodejs
install_rvm_and_ruby
setup_python
install_java_8
install_neo4j

