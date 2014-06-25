#
# Cookbook Name:: phpapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

nginx_dir = '/opt/local/etc/nginx'

include_recipe "nginx::source"

template "#{nginx_dir}/sites-available/wordpress.conf" do
  source "nginx/wordpress.conf.erb"
  owner  "www"
  mode 0644
  variables({ doc_root: default['phpapp']['git_repo_home'], host_name: '165.225.148.128' })
  notifies :run, "execute[verify nginx configuration file]"
end

nginx_site 'wordpress.conf' do
  enable true
end

execute "verify nginx configuration file" do
  command "nginx -t -c #{nginx_dir}/nginx.conf"
  action :nothing
  notifies :restart, "service[nginx]"
end

