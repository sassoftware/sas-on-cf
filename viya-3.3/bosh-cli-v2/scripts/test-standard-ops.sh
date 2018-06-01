#!/bin/bash

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
