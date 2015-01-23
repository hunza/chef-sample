#
# Cookbook Name:: app
# Attributes:: default

## supervisord settings
default['supervisor']['inet_port'] = 9001

## nginx settings
default[:nginx][:pid] = '/run/nginx.pid'
default[:nginx][:server_names_hash_bucket_size] = 128
