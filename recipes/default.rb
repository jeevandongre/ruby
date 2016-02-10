#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "mysql::server"
execute "update" do
   command "apt-get update"
end
pkgs = ['build-essential', 'zlib1g-dev', 'libreadline-dev',
        'libssl-dev', 'libcurl4-openssl-dev',
        'g++', 'bundler']

pkgs.each do |pkg|
  apt_package pkg do
    action :install
  end
end

if File::exist?('/usr/local/bin/ruby')
  log "Ruby Installed"
else
  remote_file 'ruby-2.0.0-p247' do
      source 'http://s3-ap-southeast-1.amazonaws.com/st-back-up/ruby-2.0.0-p247.tar.gz'
      path '/home/vagrant/ruby'    # Will be created if missing
  end

    bash 'extract' do
      cwd '/home/vagrant/'
      code <<-EOH
      tar -xvf ruby
      EOH
    end

    bash 'ruby' do
      cwd '/home/vagrant/ruby-2.0.0-p247'
      code <<-EOH
      ./configure
        make
      make test
      sudo make install
      EOH
    end
end

gem_package 'rake' do
  action :install
  version '10.4.2'
  options('--force')
end

gem_package "bundler" do
    action :install
end

mysql_chef_gem "mysql" do
  action :install
end
