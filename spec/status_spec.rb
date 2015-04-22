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

require 'spec_helper'

describe Chef::MonitWrapper::Status do
  include Chef::MonitWrapper::Status
  describe '.is_status_stable' do
    it 'should correctly recognize unstable status values' do
      expect(monit_status_stable?('Initializing')).to be_falsey
      expect(monit_status_stable?('Execution failed - start pending')).to be_falsey
      expect(monit_status_stable?('Running - stop pending')).to be_falsey
      expect(monit_status_stable?('Does not exist')).to be_falsey
      expect(monit_status_stable?(nil)).to be_falsey
    end

    it 'should correctly recognize stable status values' do
      expect(monit_status_stable?('Running')).to be_truthy
      expect(monit_status_stable?('Not monitored')).to be_truthy
    end
  end

  describe '.parse_monit_summary' do
    it 'should correctly parse monit status output' do
      sample_monit_stdout = <<-EOT
The Monit daemon 5.3.2 uptime: 3m

Process 'sshd'                      Running
System 'testkitchen-my-system-precise64-vagrantup-com' Running
Process 'my-service'          Not monitored
EOT
      expect(parse_monit_summary(sample_monit_stdout)).to eq({
        'sshd' => 'Running',
        'my-service' => 'Not monitored'
      })
    end

  end
end
