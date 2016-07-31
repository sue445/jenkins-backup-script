#!/bin/bash -xe

wget https://releases.hashicorp.com/vagrant/1.8.4/vagrant_1.8.4_x86_64.rpm
rpm -i vagrant_1.8.4_x86_64.rpm
vagrant plugin install vagrant-digitalocean

# NOTE: vagrant v1.8.4 depends on bundler v1.12.5
# https://github.com/mitchellh/vagrant/blob/v1.8.4/vagrant.gemspec#L23
gem uninstall bundler --all --force
gem install bundler -v 1.12.5 --no-document


mkdir -m 700 -p $HOME/.ssh

#########################
# put ssh keys
set +x

echo -e "$DIGITALOCEAN_KEY_PRIVATE" > $HOME/.ssh/id_rsa.vagrant
echo -e "$DIGITALOCEAN_KEY_PUBLIC"  > $HOME/.ssh/id_rsa.vagrant.pub

set -x
#########################

chmod 600 $HOME/.ssh/id_rsa.vagrant
