#
# Cookbook Name:: app
# Recipe:: default
#

user 'deploy' do
  uid '2004'
  shell '/usr/sbin/nologin'
end

%w{python-dev python-pip python-virtualenv}.each do |pkg|
  package pkg do
    action :install
  end
end

directory '/var/apps' do
  owner 'root'
  group 'root'
  mode 0755
end

directory '/var/apps/django-sample-app' do
  owner 'ubuntu'
  group 'root'
  mode 0755
end

%w{releases shared etc}.each do |name|
  directory "/var/apps/django-sample-app/#{name}" do
    owner 'ubuntu'
    group 'root'
    mode 0755
  end
end

%w{log run}.each do |name|
  directory "/var/apps/django-sample-app/#{name}" do
    owner 'ubuntu'
    group 'root'
    mode 0777
  end
end
