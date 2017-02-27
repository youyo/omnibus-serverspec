# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure("2") do |config|
  config.vm.define "omnibus-serverspec-#{ENV['DEGITALOCEAN_IMAGE']}" do |c|
    c.vm.provider :digital_ocean do |provider, override|
      provider.ssh_key_name = ENV['DEGITALOCEAN_SSHKEY']
      override.ssh.private_key_path = ENV['VAGRANT_PRIVATE_KEY_PATH']
      override.vm.box = 'digital_ocean'
      override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
      override.vm.synced_folder ".", "/vagrant", type: "rsync",
        rsync__args: ["--verbose", "--archive", "--delete", "--copy-links", "--times", "-z"]
      provider.token = ENV['DEGITALOCEAN_TOKEN']
      provider.image = ENV['DEGITALOCEAN_IMAGE']
      provider.region = 'sgp1'
      provider.size = '8gb'
    end
  end

  config.vm.provision "shell", inline: <<-SHELL
    yum install epel-release -y
    yum install wget make gcc gcc-c++ glibc glibc-devel kernel-devel zlib-devel openssl-devel readline-devel curl-devel sqlite-devel libyaml-devel libffi-devel rpm-build autoconf expat-devel gettext-devel perl-ExtUtils-MakeMaker -y
    cd /usr/local/src/
    wget https://www.kernel.org/pub/software/scm/git/git-2.11.1.tar.gz
    tar xvzf git-2.11.1.tar.gz
    cd git-2.11.1
    make prefix=/usr -j 4 all
    make prefix=/usr install
    git config --global user.email #{ENV['GIT_EMAIL']}
    git config --global user.name #{ENV['GIT_USERNAME']}
    curl -s https://packagecloud.io/install/repositories/youyo/omnibus-packages/script.rpm.sh | sudo bash
    yum install -y omnibus-serverspec
    /opt/ruby/bin/gem install bundler
    cd /vagrant
    /opt/ruby/bin/bundle install --binstubs
    ./bin/omnibus build serverspec
  SHELL
end
