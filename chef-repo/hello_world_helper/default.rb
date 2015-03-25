#
# Cookbook Name:: hello_world
# Recipe:: default

file '/tmp/hello_world2.txt' do
  content 'Hi there'
end

template "/tmp/hello_world.txt" do
  source "hello_world.txt.erb"
  variables( :my_name => "max" )
end
