source 'https://api.berkshelf.com'

metadata

cookbook 'monit', github: 'phlipper/chef-monit', tag: 'v1.5.4'

group :integration do
  cookbook 'monit_wrapper_test', path: 'spec/cookbooks/monit_wrapper_test'
  cookbook 'minitest-handler'
end
