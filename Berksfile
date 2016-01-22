source 'https://api.berkshelf.com'

metadata

cookbook 'monit-ng', :github => 'wan/monit-ng'

group :integration do
  cookbook 'monit_wrapper_test', path: 'test/cookbooks/monit_wrapper_test'
  cookbook 'minitest-handler'
end
