include_recipe 'nrpe'

nrpe_check "check_tcp" do
	command "#{node['nrpe']['plugin_dir']}/check_tcp -H $ARG1$ -p $ARG2$ -w $ARG3$ -c $ARG4$ $ARG5$"
    action  :add
end

nrpe_check "check_users" do
	command "#{node['nrpe']['plugin_dir']}/check_users -w $ARG1$ -c $ARG2$"
    action  :add
end

nrpe_check "check_load" do
	command "#{node['nrpe']['plugin_dir']}/check_load -w $ARG1$ -c $ARG2$"
    action  :add
end

nrpe_check "check_disk" do
	command "#{node['nrpe']['plugin_dir']}/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$"
    action  :add
end

nrpe_check "check_procs" do
	command "#{node['nrpe']['plugin_dir']}/check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$"
    action  :add
end

nrpe_check "check_procs_count" do
	command "#{node['nrpe']['plugin_dir']}/check_procs -a $ARG1$ -w $ARG2$ -c $ARG3$"
    action  :add
end

nrpe_check "check_cpu" do
	command "#{node['nrpe']['plugin_dir']}/check_cpu $ARG1$ $ARG2$"
    action  :add
end

nrpe_check "check_log" do
	command "#{node['nrpe']['plugin_dir']}ibexec/check_log  -F $ARG1$ -O $ARG2$ -q $ARG3$"
    action  :add
end

nrpe_check "check_ntp" do
	command "#{node['nrpe']['plugin_dir']}/check_ntp -H $ARG1$ -w $ARG2$ -c $ARG3$"
    action  :add
end

nrpe_check "check_filemtime" do
	command "#{node['nrpe']['plugin_dir']}ibexec/check_filemtime.sh -F $ARG1$ -w $ARG2$ -c $ARG3$ -Y $ARG4$"
    action  :add
end

nrpe_check "check_smtp" do
	command "#{node['nrpe']['plugin_dir']}/check_smtp -H $ARG1$ -w $ARG2$ -c $ARG3$"
    action  :add
end

nrpe_check "check_log" do
	command "#{node['nrpe']['plugin_dir']}/check_log -F $ARG1$ -O $ARG2$ -q $ARG3$"
    action  :add
end

nrpe_check "check_dns" do
	command "#{node['nrpe']['plugin_dir']}/check_dns -H $ARG1$ -t $ARG2$"
    action  :add
end

nrpe_check "check_dns_address" do
	command "#{node['nrpe']['plugin_dir']}/check_dns -H $ARG1$ -a $ARG3$ -t $ARG2$"
    action  :add
end

nrpe_check "check_http" do
	command "#{node['nrpe']['plugin_dir']}/check_http -p 80 -w $ARG1$ -c $ARG2$ -H $ARG3$ -u $ARG4$"
    action  :add
end

nrpe_check "check_https" do
	command "#{node['nrpe']['plugin_dir']}/check_http -p 443 -S -w $ARG1$ -c $ARG2$ -H $ARG3$ -u $ARG4$"
    action  :add
end

nrpe_check "check_http_regex" do
	command "#{node['nrpe']['plugin_dir']}/check_http -p 80 -w $ARG1$ -c $ARG2$ -H $ARG3$ -u $ARG4$ -r $ARG5$"
    action  :add
end

nrpe_check "check_https_regex" do
	command "#{node['nrpe']['plugin_dir']}/check_http -p 443 -S -w $ARG1$ -c $ARG2$ -H $ARG3$ -u $ARG4$ -r $ARG5$"
    action  :add
end

nrpe_check "check_http_code" do
	command "#{node['nrpe']['plugin_dir']}/check_http -p 80 -w $ARG1$ -c $ARG2$ -H $ARG3$ -u $ARG4$ -e $ARG5$"
    action  :add
end

nrpe_check "check_https_code" do
	command "#{node['nrpe']['plugin_dir']}/check_http -p 443 -S -w $ARG1$ -c $ARG2$ -H $ARG3$ -u $ARG4$ -e $ARG5$"
    action  :add
end
