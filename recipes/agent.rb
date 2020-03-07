#
# Cookbook:: line_cook
# Recipe:: agent
#
# Copyright:: 2020, h4ckNinja, All Rights Reserved.


if platform?('windows')
	remote_file node['line_cook']['agent']['windows']['save_path'] do
		source node['line_cook']['agent']['windows']['download']
		action :create_if_missing
	end

	ruby_block 'agent' do
		block do
			pid = spawn("#{node['line_cook']['agent']['windows']['save_path']}")

			Process.detach(pid)
		end
	end
end


if platform?('amazon', 'arch', 'debian', 'fedora', 'gentoo', 'opensuseleap', 'slackware', 'suse', 'ubuntu')
	remote_file node['line_cook']['agent']['linux']['save_path'] do
		source node['line_cook']['agent']['linux']['download']
		action :create_if_missing
	end

	execute 'permissions' do
		command "chmod +x #{node['line_cook']['agent']['linux']['save_path']}"
	end

	ruby_block 'agent' do
		block do
			pid = spawn("#{node['line_cook']['agent']['linux']['save_path']}")

			Process.detach(pid)
		end
	end
end
