#
# Cookbook Name:: app
# Recipe:: uwsgi
#
include_recipe 'supervisor::default'

## uWSGI
directory "/var/apps/django-sample-app/etc/uwsgi" do
  owner 'ubuntu'
  group 'root'
  mode 0755
end

template "/var/apps/django-sample-app/etc/uwsgi/django-sample-app-uwsgi.ini" do
  owner 'ubuntu'
  group 'root'
  mode 0644
  source "uwsgi/django-sample-app-uwsgi.ini.erb"
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
