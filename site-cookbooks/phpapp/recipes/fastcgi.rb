package 'spawn-fcgi'

directory "/var/run/php-fastcgi" do
  recursive true
  owner "www"
  group "www"
end

template "/opt/local/bin/php-fastcgi" do
  source "fast-cgi.erb"
  mode 0755
  owner "www"
  group "www"
end
