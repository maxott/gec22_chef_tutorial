#
# Cookbook Name:: oml
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'apt'
#package 'magic_shell'
#package 'yum'

case node["platform_family"]
when "debian"
  include_recipe "apt"

  pkg_list = %w(build-essential libssl-dev)

  case node["platform"]
  when "debian"
    o_k = "http://download.opensuse.org/repositories/home:cdwertmann:oml/Debian_#{node["platform_version"].to_i}.0/Release.key"
    o_u = "http://download.opensuse.org/repositories/home:/cdwertmann:/oml/Debian_#{node["platform_version"].to_i}.0/"
    v_check = "7"
  when "ubuntu"
    o_k = "http://download.opensuse.org/repositories/home:cdwertmann:oml/xUbuntu_#{node["platform_version"]}/Release.key"
    o_u = "http://download.opensuse.org/repositories/home:/cdwertmann:/oml/xUbuntu_#{node["platform_version"]}/"
    v_check = "13.04"
  end

  pkg_list += node["platform_version"] < v_check ? %w(ruby1.9.1 ruby1.9.1-dev) : %w(ruby ruby-dev)

  apt_repository 'oml' do
    key o_k
    uri o_u
    components ['/']
  end
when "fedora"
  magic_shell_environment "PATH" do
    value "$PATH:/usr/local/bin"
  end
  pkg_list = %w(ruby ruby-devel make gcc gpp gcc-c++ openssl-devel)

  unless node["platform_version"].to_i < 17
    o_url = "http://download.opensuse.org/repositories/home:cdwertmann:oml/Fedora_#{node["platform_version"]}/"
  else
    oml2_not_found = true
  end

  unless oml2_not_found
    yum_repository 'oml' do
      description "OML packages"
      baseurl o_url
      gpgcheck false
      action :create
    end
  end
when "rhel"
  # FIXME Failed in CentOS 6.5
  pkg_list = %w(centos-release-SCL ruby193 ruby193-ruby-devel make gcc gcc-c++ openssl-devel)
end

pkg_list << "oml2-apps" unless oml2_not_found

pkg_list.each do |p|
  package p do
    action :install
  end
end

