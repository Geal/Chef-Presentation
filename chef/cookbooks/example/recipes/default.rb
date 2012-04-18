package "curl"
package "ntp"
package "apache2"
package "openssh-server"

hostname = node[:servername]

file '/etc/hostname' do
  content "#{hostname}\n"
end

service 'hostname.sh' do
  action :restart
end

template "/etc/apache2/sites-available/vhosts" do
  source "vhosts.erb"
  owner  "root"
  group  "root"
  mode   0644
end

execute "a2ensite" do
  command "a2ensite vhosts"
  creates "/etc/apache2/sites-enabled/vhosts"
  action :run
end

package 'git-core'

execute 'git' do
  command 'git clone git://github.com/Geal/Chef-Presentation.git presentation'
  cwd '/var/www'
  creates '/var/www/presentation/README.md'
  action :run
end

service 'apache2' do
  action :restart
end



