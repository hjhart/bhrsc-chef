#
# Cookbook Name:: phpapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

include_recipe 'phpapp::nginx'
include_recipe 'phpapp::php'

template "/opt/local/bin/php-fastcgi" do
  source "fast-cgi.erb"
  mode 0755
  owner "www"
  group "www"
end
