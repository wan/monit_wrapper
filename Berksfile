source 'https://api.berkshelf.com'

metadata

cookbook 'monit', github: 'phlipper/chef-monit', tag: '1.5.2'

group :integration do
  cookbook 'monit-wrapper-test', path: 'spec/cookbooks/monit-wrapper-test'
  cookbook 'minitest-handler'
end
