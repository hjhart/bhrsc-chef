user = node['phpapp']['user']
group = node['phpapp']['group']
home_dir = node['phpapp']['home']

group group do
  action :create
end

user user do
  group group
  shell "/bin/bash"
  comment "Wordpress app user"
  supports :manage_home => true
  home home_dir
end

directory "#{home_dir}/.ssh" do
  owner user
  group group
  mode "0700"
end

# Allow us to check out code from github
cookbook_file "#{home_dir}/.ssh/id_rsa" do
  source "keys/id_rsa_deploy"
  owner user
  group group
  mode "0400"
end

cookbook_file "#{home_dir}/.ssh/id_rsa.pub" do
  source "keys/id_rsa_deploy.pub"
  owner user
  group group
  mode "0400"
end

cookbook_file "#{home_dir}/.ssh/config" do
  source "ssh/config"
  owner user
  group group
  mode "0400"
end

git "/opt/mysources/couch" do
  repository "git://git.apache.org/couchdb.git"
  revision "master"
  action :sync
end

git node['phpapp']['git_repo_home'] do
  repository "git@github.com:hjhart/bhrsc.git"
  action :sync
  owner user
  group group
end
