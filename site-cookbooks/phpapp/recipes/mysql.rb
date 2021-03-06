package "mysql-server"

service "mysql" do
  action :start
end

mysql_user = node['phpapp']['mysql']['user']
mysql_database = node['phpapp']['mysql']['database']
mysql_password = node['phpapp']['mysql']['password']

execute %Q{ echo 'create database #{mysql_database}' | mysql -u root } do
  not_if %Q{ echo 'show databases' | mysql -u root | grep bhrsc }
end

execute %Q{ echo 'GRANT ALL PRIVILEGES ON *.* TO '#{mysql_user}'@'localhost' IDENTIFIED BY '#{mysql_password}' WITH GRANT OPTION; | mysql -u root }