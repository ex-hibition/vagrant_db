#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "install td-agent by using rpm" do
	command "curl -L http://toolbelt.treasure-data.com/sh/install-redhat.sh | sh"
	only_if { node['hostname'] == "dbmaster" }
end

template "fluent.conf.erb" do
	path "/etc/td-agent/td-agent.conf"
	source "fluent.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	notifies :restart, "service[td-agent]"
	only_if { node['hostname'] == "dbmaster" }
end

service "td-agent" do
	action [:enable, :start]
	only_if { node['hostname'] == "dbmaster" }
end
