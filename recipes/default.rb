#
# Cookbook:: ohmyzsh
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.
#
include_recipe 'git::default'

package 'curl'
package 'zsh'

template "/home/#{node['ohmyzsh']['user']}/install.sh" do
  source 'install.sh.erb'
  owner node['ohmyzsh']['user']
  group node['ohmyzsh']['user']
  mode '644'
end

execute 'install oh-my-zsh install script' do
  cwd "/home/#{node['ohmyzsh']['user']}"
  user node['ohmyzsh']['user']
  environment ({ 'HOME' => "/home/#{node['ohmyzsh']['user']}", 'USER' => "#{node['ohmyzsh']['user']}" })
  command 'sh install.sh'
  creates "/home/#{node['ohmyzsh']['user']}/.oh-my-zsh"
end

file "/home/#{node['ohmyzsh']['user']}/install.sh" do
  action :delete
end

template '/etc/shells' do
  source 'etc/shells.erb'
  owner 'root'
  group 'root'
  mode '644'
end

execute 'set zsh as default shell' do
  zsh_is_already_default = 'echo $SHELL | grep -c zsh'
  user node['ohmyzsh']['user']
  environment ({ 'HOME' => "/home/#{node['ohmyzsh']['user']}", 'USER' => "#{node['ohmyzsh']['user']}" })

  command "sudo chsh -s $(which zsh) #{node['ohmyzsh']['user']}"
  not_if zsh_is_already_default
end
