#
# Cookbook Name:: app
# Recipe:: proxy
#
include_recipe 'nginx::default'

template "/etc/nginx/sites-available/django-sample-app" do
  owner 'root'
  group 'root'
  mode 0644
  source "nginx/django-sample-app.erb"
end

nginx_site 'default' do
  enable false
end

nginx_site 'django-sample-app' do
  enable true
end
