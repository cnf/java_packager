package "build-essential" do
  action :install
end

gem_package "fpm" do
  action :install
end

pkgprefix = "#{Chef::Config[:file_cache_path]}/java/"

directory "#{pkgprefix}/opt/jdk#{node['java']['target']}" do
  action :create
  recursive true
end

bash "unpack java" do
  user "root"
  cwd "#{pkgprefix}/opt/jdk#{node['java']['target']}"
  code <<-EOF
    tar -xzvf /vagrant/#{node['java']['raw']} --strip-components=1
  EOF
end

template "#{pkgprefix}/postinst" do
  source "postinst.erb"
  mode 0755
  owner "root"
  group "root"
end

template "#{pkgprefix}/prerm" do
  source "prerm.erb"
  mode 0755
  owner "root"
  group "root"
end

### FPM!!
bash "fpm DEB package oracle java" do
  user "root"
  cwd "#{pkgprefix}"
  code <<-EOF
    fpm -s dir -t deb -n oracle-jdk -v #{node['java']['target']} \
      -C "#{pkgprefix}" \
      -p oracle-jdk-VERSION_ARCH.deb \
      --after-install #{pkgprefix}/postinst \
      --before-remove #{pkgprefix}/prerm \
      --vendor "#{node['vendorname']}" -m "#{node['maintainer']}" \
      --description "Oracle JDK, packaged by #{node['vendorname']}" \
      --url "http://www.oracle.com/technetwork/java/javase/downloads/index.html" \
      --license "Oracle Binary Code License Agreement" \
      opt/
  EOF
end

execute "mv package to /vagrant/" do
  command "mv -f #{pkgprefix}/oracle-*.deb /vagrant/"
end
