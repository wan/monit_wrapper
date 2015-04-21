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


class Chef
  module MonitWrapper
    # Actions we may need to run during Chef compile time.
    module CompileTime

      # Install the Monit package at Chef compile time so we can query process status.
      def install_monit_at_compile_time
        package('monit').run_action(:install)
        service('monit').run_action(:start)
      end

    end
  end
end

Chef::Recipe.send(:include, Chef::MonitWrapper::CompileTime)
