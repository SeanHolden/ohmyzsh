# # encoding: utf-8

# Inspec test for recipe ohmyzsh::default on centos platform

describe package('curl') do
  it { should be_installed }
end

describe package('zsh') do
  it { should be_installed }
end

describe file('/home/vagrant/.zshrc') do
  it { should exist }
end

describe directory('/home/vagrant/.oh-my-zsh') do
  it { should exist }
end

describe file('/home/vagrant/install.sh') do
  it { should_not exist }
end

describe file('/etc/shells') do
  its('md5sum') { should eq 'bf63d8e59618ad825ffdca15aabdbcf9' }
end
