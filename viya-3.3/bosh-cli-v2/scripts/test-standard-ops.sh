#!/bin/bash

# This script is a derivative work and based on those included in
# https://github.com/cloudfoundry/cf-deployment/blob/master/scripts/test. The
# following text is the NOTICE file content for that project.
#
# cf-deployment
#
# Copyright (c) 2016-Present CloudFoundry.org Foundation, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

test_standard_ops() {
  # Padded for pretty output
  suite_name="STANDARD          "

  pushd ${home} > /dev/null
    pushd operations > /dev/null
      if interpolate ""; then
        pass "deployment-manifest.yml"
      else
        fail "deployment-manifest.yml"
      fi
      check_interpolation "add-sas-programming.yml"
      check_interpolation "configure-db-ports.yml"
      check_interpolation "enable-distributed-cas.yml"
      check_interpolation "enable-nfs.yml"
      check_interpolation "enable-sssd.yml"
      check_interpolation "programming-only.yml"
      check_interpolation "rename-default-network.yml"
      check_interpolation "site-defaults.yml"
      check_interpolation "use-vip-network.yml"
    popd > /dev/null # operations
  popd > /dev/null
  exit $exit_code
}
