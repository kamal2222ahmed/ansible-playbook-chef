node['limits'].each do |name, data|

    use_system = (name == '*')

    values = [data].flatten

    values.each do |hash|

        set_limit name do 
            type hash['type']
            item hash['item']
            value hash['value']
            use_system use_system
        end

    end

end
