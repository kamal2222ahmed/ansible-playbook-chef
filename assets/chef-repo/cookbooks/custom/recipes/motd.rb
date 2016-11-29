if node['motd']['banner'] != []

    file node['motd']['banner_file'] do
        content node['motd']['banner'].join("\n")
    end

end

if node['motd']['tail'] != []
    file node['motd']['tail_file'] do
        content node['motd']['tail'].join("\n")
    end
end

if node['motd']['issue'] != []
    file node['motd']['issue_file'] do
        content node['motd']['issue'].join("\n")
    end
end
