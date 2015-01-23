#
# Cookbook Name:: master
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{python-dev python-pip ruby2.0 ruby2.0-dev git curl autoconf}.each do |pkg|
  package pkg do
    action :install
  end
end

execute 'ruby2.0-bundler' do
  command '/usr/bin/gem2.0 install bundler'
  not_if { ::File.exists?('/usr/local/bin/bundle') }
end

python_pip 'fabric' do
  version '1.10.1'
end

python_pip 'awscli' do
  version '1.7.3'
end
