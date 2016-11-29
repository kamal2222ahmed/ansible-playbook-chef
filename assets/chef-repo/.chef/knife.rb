current_dir = File.dirname(__FILE__)
chef_repo = File.join(current_dir, "..")

chef_server_url          "http://127.0.0.1:8889"
node_name                "dummy"
client_key               File.join(current_dir, "dummy.pem")
cache_type               'BasicFile'
cache_options            :path => "#{chef_repo}/checksums"
cookbook_path            "#{chef_repo}/cookbooks"
