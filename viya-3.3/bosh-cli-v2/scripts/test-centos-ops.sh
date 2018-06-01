#!/bin/bash

test_centos_ops() {
  # Padded for pretty output
  suite_name="CENTOS          "

  pushd ${home} > /dev/null
    pushd operations > /dev/null
      if interpolate ""; then
        pass "deployment-manifest.yml"
      else
        fail "deployment-manifest.yml"
      fi
      check_interpolation "add-sas-programming-centos.yml"
      check_interpolation "centos.yml"
      check_interpolation "enable-nfs-centos.yml"
      check_interpolation "enable-sssd-centos.yml"
    popd > /dev/null # operations
  popd > /dev/null
  exit $exit_code
}

