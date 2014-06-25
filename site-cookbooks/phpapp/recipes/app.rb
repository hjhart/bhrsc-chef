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

execute "chown #{user}:#{group} -R #{home_dir}"

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

git node['phpapp']['git_repo_home'] do
  repository "git@github.com:hjhart/bhrsc.git"
  action :sync
  user user
  group group
end

template "#{node['phpapp']['git_repo_home']}/bhrsc.com/wp-config.php" do
  source 'wp-config.php.erb'
  owner user
  group group
  mode 0644
end