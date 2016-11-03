# frozen_string_literal: true
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'trusty32'
  config.vm.box_url = '/mnt/vm/32bits/package.box'

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
    ### Change network card to PCnet-FAST III
    # For NAT adapter
    vb.customize ['modifyvm', :id, '--nictype1', 'Am79C973']
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3010
  config.vm.network :forwarded_port, guest: 80, host: 8080
  # config.vm.network :private_network, ip: '192.168.66.66'
  config.ssh.forward_agent = true
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'

  provision_shell_root = <<-SCRIPT
    apt-get update
    sudo apt-get --yes install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev htop
  SCRIPT

  provision_shell_user = <<-SCRIPT
    echo ############################# node.js #############################
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs
    cd

    echo ############################# rbenv #############################
    cd
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

    echo ############################# ruby 2.3.1 #############################
    rbenv install 2.3.1
    rbenv global 2.3.1
    ruby -v

    echo ############################# bundler #############################
    gem update --system
    yes | gem update
    gem install bundler

    echo ############################# rails #############################
    gem install rails
    rbenv rehash
    rails -v

    SCRIPT

  provision_shell_mysql = <<-SCRIPT
    echo ############################# postgresql #############################
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password'
    sudo apt-get --yes install mysql-server mysql-client libmysqlclient-dev
    mysql -u root -e "create user 'rails'@'localhost' identified by 'rails';"
    mysql -u root -e "grant all on *.* to 'rails'@'localhost';"
    # for access from host, see: http://serverfault.com/questions/366532/opening-port-3306-for-remote-mysql-from-vm
  SCRIPT

  # provision_shell_postgresql = <<-SCRIPT
  #   echo ############################# postgresql #############################
  #   sudo locale-gen es_ES.UTF-8
  #   sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
  #   wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
  #   sudo apt-get update
  #   sudo apt-get install postgresql-common
  #   sudo apt-get install postgresql-9.5 libpq-dev
  #
  #   echo # postgresql user
  #   sudo -u postgres createuser ubuntu -s
  #   sudo -u postgres psql -c "ALTER USER ubuntu WITH PASSWORD 'ubuntu';"
  # SCRIPT
  #

  config.vm.provision 'shell', inline: provision_shell_root
  config.vm.provision 'shell', inline: provision_shell_user, privileged: false
  config.vm.provision 'shell', inline: provision_shell_mysql
  # config.vm.provision 'shell', inline: provision_shell_postgresql

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
