# Copyright 2015 ClearStory Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'monit_wrapper'

myservice_script = '/usr/local/bin/myservice.sh'

cookbook_file myservice_script do
  source 'myservice.sh'
  mode 0755
end

user 'myuser'

directory '/var/log/myservice' do
  user 'myuser'
  group 'myuser'
end

monit_wrapper_monitor 'myservice' do
  template_source 'pattern-based_service.conf.erb'
  template_cookbook 'monit_wrapper'
  variables cmd_line: "/bin/bash #{myservice_script}",
            cmd_line_pattern: "/bin/bash #{myservice_script}",
            user: 'myuser',
            out_file: '/var/log/myservice/myservice.out',
            err_file: '/var/log/myservice/myservice.err'
end

monit_wrapper_service 'myservice' do
  action :start
end

monit_wrapper_service 'myservice' do
  action :stop
end
