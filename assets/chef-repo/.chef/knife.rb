current_dir = File.dirname(__FILE__)
#user_email  = `git config --get user.email`
#user_name   = `git config --get user.name`
home_dir    = ENV['HOME'] || ENV['HOMEDRIVE']
org         = ENV['chef_org'] || 'my_org'

knife_override = "#{home_dir}/.chef/knife_override.rb"

chef_server_url          "https://localhost:8889"
log_level                :info
log_location             STDOUT

# USERNAME is UPPERCASE in Windows, but lowercase in the Chef server,
# so `downcase` it.
#node_name                ( ENV['USER'] || ENV['USERNAME'] ).downcase
node_name                "dummy"
client_key               "dummy.pem"
cache_type               'BasicFile'
cache_options( :path => "#{home_dir}/.chef/checksums" )

# We keep our cookbooks in separate repos under a ~/chef/cookbooks dir
cookbook_path            ["#{current_dir}/../cookbooks"]
#cookbook_copyright       "#{user_name}"
#cookbook_license         "MIT"
#cookbook_email           "#{user_email}"

#http_proxy               "http://proxy:80"
#https_proxy              "http://proxyg:80"
#no_proxy                 "localhost"


# Allow overriding values in this knife.rb
Chef::Config.from_file(knife_override) if File.exist?(knife_override)
