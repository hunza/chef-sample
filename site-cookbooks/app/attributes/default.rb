#
# Cookbook Name:: app
# Attributes:: default

## Ubuntu default
default['authorization']['sudo']['sudoers_defaults'] = [
  'env_reset',
  'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'
]
default['authorization']['sudo']['groups'] = ['admin', 'sudo']
default['authorization']['sudo']['include_sudoers_d'] = true

## supervisord settings
default['supervisor']['inet_port'] = 9001

## nginx settings
default[:nginx][:pid] = '/run/nginx.pid'
default[:nginx][:server_names_hash_bucket_size] = 128
