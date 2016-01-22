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

name             'monit_wrapper'
maintainer       'ClearStory Data, Inc.'
maintainer_email 'mbautin@clearstorydata.com'
license          'Apache License 2.0'
description      'A wrapper around Monit making it easier to monitor services'
version          '3.3.0'
source_url       'https://github.com/clearstorydata-cookbooks/monit_wrapper' if respond_to?(:source_url)
issues_url       'https://github.com/clearstorydata-cookbooks/monit_wrapper/issues' if respond_to?(:issues_url)

%w( debian ubuntu redhat centos fedora ).each do |os|
  supports os
end

depends 'apt'
depends 'monit-ng'
depends 'notifying-action', '~> 1.0.1'
