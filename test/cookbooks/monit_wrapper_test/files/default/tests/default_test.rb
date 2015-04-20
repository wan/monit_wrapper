# Copyright © 2015 ClearStory Data, Inc.
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

require 'minitest/spec'
require 'logger'

# :nodoc:
module MonitWrapperSpecHelpers
  # Sleep for a short time after every monit command to allow changes to take effect.
  DELAY_AFTER_MONIT_CMD_SEC = 0.5

  def stop_start_service
    stop_monit_service('myservice')
    sleep(DELAY_AFTER_MONIT_CMD_SEC)
    assert_equal('Not monitored', get_stable_monit_service_status('myservice'))

    start_monit_service('myservice')
    sleep(DELAY_AFTER_MONIT_CMD_SEC)
    assert_equal('Running', get_stable_monit_service_status('myservice'))
  end
end

# A minitest test for the monit_wrapper cookbook.
class MonitWrapperSpec < MiniTest::Chef::Spec
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions
  include Chef::MonitWrapper::Status
  include Chef::MonitWrapper::StartStop

  include MonitWrapperSpecHelpers


  describe_recipe 'monit_wrapper_test::default' do

    it 'creates the myuser user' do
      user('myuser').must_exist
    end

    it 'creates the myuser group' do
      user('myuser').must_exist
    end

    it 'installs the "monit" package' do
      package('monit').must_be_installed
    end

    it 'creates the Monit configuration for the "myservice" service' do
      file('/etc/monit/conf.d/myservice.monitrc').must_exist
    end

    it 'allows stopping and starting "myservice" service using monit' do
      stop_start_service
    end

    it 'creates standard output and standard error files' do
      stop_start_service

      file('/var/log/myservice/myservice.out').must_exist
      file('/var/log/myservice/myservice.err').must_exist
    end

    it 'stop_monit_service, start_monit_service' do
      stop_monit_service('myservice')
      assert_equal('Not monitored', get_stable_monit_service_status('myservice'))
      start_monit_service('myservice')
      assert_equal('Running', get_stable_monit_service_status('myservice'))
    end

    it 'start_monit_service, stop_monit_service' do
      start_monit_service('myservice')
      assert_equal('Running', get_stable_monit_service_status('myservice'))
      stop_monit_service('myservice')
      assert_equal('Not monitored', get_stable_monit_service_status('myservice'))
    end

    it 'restart_monit_service for a service that is initially not running' do
      stop_monit_service('myservice')
      assert_equal('Not monitored', get_stable_monit_service_status('myservice'))
      restart_monit_service('myservice')
      assert_equal('Running', get_stable_monit_service_status('myservice'))
    end

    it 'restart_monit_service for a service that is initially running' do
      start_monit_service('myservice')
      assert_equal('Running', get_stable_monit_service_status('myservice'))
      restart_monit_service('myservice')
      assert_equal('Running', get_stable_monit_service_status('myservice'))
    end

  end
end
