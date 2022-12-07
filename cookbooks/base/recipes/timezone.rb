#
# Cookbook:: base
# Recipe:: timezone
#
# Copyright:: 2022, The Authors, All Rights Reserved.

link '/etc/localtime' do
  to '/usr/share/zoneinfo/America/Sao_Paulo'
  not_if "readlink /etc/localtime | egrep -q '^Sao_Paulo$'"
end
