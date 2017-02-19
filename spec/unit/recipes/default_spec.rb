#
# Cookbook:: ohmyzsh
# Spec:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

require 'spec_helper'

describe 'ohmyzsh::default' do
  context 'When all attributes are default, on Centos7' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }
    let(:ohmyzsh_installed) { false }

    before do
      stub_command("echo $SHELL | grep -c zsh").and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe 'curl' do
      it 'installs successfully' do
        expect(chef_run).to install_package('curl')
      end
    end

    describe 'zsh' do
      it 'installs successfully' do
        expect(chef_run).to install_package('zsh')
      end
    end

    describe '#templates' do
      it 'creates ~/install.sh' do
        expect(chef_run).to create_template('/home/vagrant/install.sh').with(
          owner: 'vagrant',
          group: 'vagrant',
          mode: '644'
        )
      end

      it 'creates ~/install.sh' do
        expect(chef_run).to create_template('/etc/shells').with(
          owner: 'root',
          group: 'root',
          mode: '644'
        )
      end
    end

    describe 'oh-my-zsh' do
      it 'executes command correctly' do
        expect(chef_run).to run_execute('sh install.sh').with(user: 'vagrant')
      end
    end
  end
end
