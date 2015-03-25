#
# Cookbook Name:: omf_rc
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

gem_package "omf_rc" do
  action [:remove, :install]
end

bash "install_omf_rc_start_script" do
  code "install_omf_rc -i"
end

directory "/etc/omf_rc"

#template "/etc/omf_rc/topology" do
#  source "topology"
#end

template "/etc/omf_rc/config.yml" do
  source "config.yml"
end

service "omf_rc" do
  provider Chef::Provider::Service::Upstart if platform?("ubuntu")
  action [:stop, :start]
end

