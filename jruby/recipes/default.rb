include_recipe "java"

version = node[:jruby][:version]
prefix = node[:jruby][:prefix]

versioned_dest = File.join(prefix, "/jruby-#{version}")
linked_dest = File.join(prefix, "/jruby")

remote_file "/tmp/jruby-bin-#{version}.tar.gz" do
  source "http://dist.codehaus.org/jruby/#{version}/jruby-bin-#{version}.tar.gz"
  mode "0644"
  # TODO: Does this need a not_if { FileTest.exists?("/tmp/monit-5.0.3.tar.gz") }?
end

bash "unpack_jruby" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -xcvf /tmp/jruby-bin-#{version}.tar.gz
    mv /tmp/jruby-#{version} #{versioned_dest}")}
  EOH
  not_if { FileTest.exists?(versioned_dest) }
end

link linked_dest do
  to versioned_dest
end

# TODO: Add jruby/bin to PATH in .profile

