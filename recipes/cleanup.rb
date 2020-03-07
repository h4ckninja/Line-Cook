#
# Cookbook:: line_cook
# Recipe:: agent
#
# Copyright:: 2020, h4ckNinja, All Rights Reserved.


if platform?('windows')
	file node['line_cook']['agent']['windows']['save_path'] do
		action :delete
	end
end


if platform?('amazon', 'arch', 'debian', 'fedora', 'gentoo', 'opensuseleap', 'slackware', 'suse', 'ubuntu')
	remote_file node['line_cook']['agent']['linux']['save_path'] do
		action :delete
	end
end
