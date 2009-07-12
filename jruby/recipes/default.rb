include_recipe "java"

version = node[:version]
prefix = node[:prefix]

remote_file "/tmp/jruby-bin-#{version}.tar.gz" do
  source "http://dist.codehaus.org/jruby/#{version}/jruby-bin-#{version}.tar.gz"
  mode "0644"
  # Does this need a not_if { FileTest.exists?("/tmp/monit-5.0.3.tar.gz") }?
end

bash "unpack_jruby" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -xcvf /tmp/jruby-#{version}.tar.gz
    mv /tmp/monit-#{version} /opt
  EOH
  not_if { FileTest.exists?(Dir.join(prefix, "/jruby-#{version}")) }
end

link "/opt/jruby" do
  to "/opt/jruby-#{version}"
end

