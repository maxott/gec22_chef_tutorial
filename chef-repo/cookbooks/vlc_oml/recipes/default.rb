#
# Cookbook Name:: vlc_oml
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'vlc' do
  action :install
  options "--force-yes"
end

execute "install_vlc_with_oml" do
  cmds =  [
    "wget https://github.com/mytestbed/gec_demos_tutorial/raw/master/gec22_demo/vlc-oml-ubuntu-12.04.tgz --no-check-certificate -O /tmp/vlc-oml-ubuntu-12.04.tgz",
    "tar -C /usr -xzf /tmp/vlc-oml-ubuntu-12.04.tgz"
  ]
  command "#{cmds.join(';')}"
end

