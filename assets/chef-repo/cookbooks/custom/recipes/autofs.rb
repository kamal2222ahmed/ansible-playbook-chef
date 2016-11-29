include_recipe 'nfs'

package 'autofs'

service 'autofs' do
    action :enable
    subscribes :restart, 'automaster_entry[staff]'
end

if node['autofs']['mountpoints'].size > 0

    node['autofs']['mountpoints'].map { |h| File.dirname(h['path']) }.each do |path|
        directory path
    end

    node['autofs']['mountpoints'].map { |h| File.dirname(h['path']) }.each do |path|
        directory path
    end

    file node['autofs']['config_file'] do
        content node['autofs']['mountpoints'].map { |h| [h['path'], h['options'], h['target'], "\n"].join(' ') }.join("\n")
    end

end
