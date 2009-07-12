# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

%w{ flex bison }.each do |pkg|
  package pkg
end

remote_file "/tmp/monit-5.0.3.tar.gz" do
  source "http://mmonit.com/monit/dist/monit-5.0.3.tar.gz"
  mode "0644"
  checksum "5dd2539b3c61d109fa75ef"
  # Does this need a not_if { FileTest.exists?("/tmp/monit-5.0.3.tar.gz") }?
end

bash "install_monit" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -xcvf /tmp/monit-5.0.3.tar.gz
    cd monit-5.0.3
    ./configure 
    make
    make install
  EOH
  not_if { FileTest.exists?("/usr/local/bin/monit") }
end

service "monit" do
  start_command "monit"
  stop_command "monit quit"
  restart_command "monit reload"
  reload_command "monit reload"
end

template "/etc/monitrc" do
  source "monitrc.erb"
  mode 0644
  variables :alert_email => node[:monit][:alert_email],
            :poll_interval => node[:monit][:poll_interval]
  notifies :restart, resources(:service => "monit")
end


