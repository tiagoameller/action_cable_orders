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
  config.vm.box = 'ubuntu/trusty32'

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
    ### Change network card to PCnet-FAST III
    # For NAT adapter
    vb.customize ['modifyvm', :id, '--nictype1', 'Am79C973']
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3010
  config.vm.network :forwarded_port, guest: 3306, host: 4406
  config.vm.network :forwarded_port, guest: 80, host: 8080
  # config.vm.network :private_network, ip: '192.168.66.66'
  config.ssh.forward_agent = true
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'

  script_env = { APP_NAME: 'comesano' }

  provision_shell_root = <<-SCRIPT
    apt-get update
    sudo apt-get --yes install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev htop
  SCRIPT

  provision_shell_user = <<-SCRIPT
    ################################# node.js #############################
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs
    cd

    ################################# rbenv #############################
    cd
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

    ################################# ruby 2.3.1 #############################
    rbenv install 2.3.1
    rbenv global 2.3.1
    ruby -v

    ################################# bundler #############################
    gem update --system
    yes | gem update
    gem install bundler

    ################################# rails #############################
    gem install rails
    rbenv rehash
    rails -v

    SCRIPT

  provision_shell_mysql = <<-SCRIPT
    ################################# mysql #############################
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password rails'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rails'
    sudo apt-get --yes install mysql-server mysql-client libmysqlclient-dev
    # grant access from outside VM
    sudo sed -i -- 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
    sudo /etc/init.d/mysql restart
    mysql -u root -prails -e "create user 'rails'@'%' identified by 'rails';"
    mysql -u root -prails -e "grant all on *.* to 'rails'@'%' identified by 'rails';"
  SCRIPT

  provision_shell_app = <<-SCRIPT
    ################################# app #############################
    cd /vagrant/$APP_NAME
    export PATH=$PATH:/home/vagrant/.rbenv/shims/
    bundle install
    bundle update
    export SECRET_KEY_BASE=`rake secret`
    echo "SECRET_KEY_BASE=\"$SECRET_KEY_BASE"\" | sudo tee --append /etc/environment
    RAILS_ENV=production rake db:create db:migrate db:seed
  SCRIPT

  provision_shell_production_server = <<-SCRIPT
    ################################# app #############################
    # here we are: https://gorails.com/deploy/ubuntu/16.04
    # better use passenger than puma
    # or unicorn: https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-unicorn-and-nginx-on-ubuntu-14-04

    # mkdir -p shared/pids shared/sockets shared/log
    # cd ~
    # wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
    # wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf
    # sed -i -- 's/id apps/id rails/g' puma.conf
    # sudo cp puma.conf puma-manager.conf /etc/init
    # echo "/vagrant/$APP_NAME" | sudo tee --append /etc/puma.conf
  SCRIPT

  # provision_shell_postgresql = <<-SCRIPT
  #   ################################# postgresql #############################
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

  # config.vm.provision 'shell', inline: provision_shell_root, name: 'PROVISION_SHELL_ROOT', env: script_env
  # config.vm.provision 'shell', inline: provision_shell_user, name: 'PROVISION_SHELL_USER', env: script_env, privileged: false
  # config.vm.provision 'shell', inline: provision_shell_mysql, name: 'PROVISION_SHELL_MYSQL', env: script_env
  # config.vm.provision 'shell', inline: provision_shell_app, name: 'PROVISION_SHELL_APP', env: script_env, privileged: false
  config.vm.provision 'shell', inline: provision_shell_production_server, name: 'PROVISION_SHELL_PRODUCTION_SERVER', env: script_env

  # config.vm.provision 'shell', inline: provision_shell_postgresql, name: 'PROVISION_SHELL_POSTGRESQL', env: script_env

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
