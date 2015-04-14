source 'http://berkshelf-api.clearstorydatainc.com:26200'
source 'https://api.berkshelf.com'

cookbook 'clearstorydata'

metadata

# We use a non-community monit recipe
cookbook 'monit', github: 'phlipper/chef-monit', tag: '1.5.2'

group :integration do
  cookbook 'monit-wrapper-test', :path => 'spec/cookbooks/monit-wrapper-test'
  cookbook 'minitest-handler'
end
