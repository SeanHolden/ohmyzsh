if platform?('centos')
  default['ohmyzsh']['user'] = 'vagrant'
elsif platform?('ubuntu')
  default['ohmyzsh']['user'] = 'ubuntu'
end
