#
# Cookbook Name:: app
# Recipe:: default
#
include_recipe 'supervisor::default'

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

directory "/var/apps/django-sample-app/etc/uwsgi" do
  owner 'ubuntu'
  group 'root'
  mode 0755
end

template "/var/apps/django-sample-app/etc/uwsgi/django-sample-app-uwsgi.ini" do
  owner 'ubuntu'
  group 'root'
  mode 0644
  source "django-sample-app-uwsgi.ini.erb"
  variables({
    :root_dir => '/var/apps/django-sample-app',
  })
end

supervisor_service "django-sample-app-uwsgi" do
  action :enable
  autostart false
  autorestart false
  user 'deploy'
  command '/var/apps/django-sample-app/current/virtualenv/bin/uwsgi --ini=/var/apps/django-sample-app/etc/uwsgi/django-sample-app-uwsgi.ini'
  stdout_logfile '/var/apps/django-sample-app/log/django-sample-app-uwsgi.log'
  stderr_logfile '/var/apps/django-sample-app/log/django-sample-app-uwsgi.err'
end
