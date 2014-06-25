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
include_recipe 'phpapp::fastcgi'
include_recipe 'phpapp::mysql'
include_recipe 'phpapp::app'

