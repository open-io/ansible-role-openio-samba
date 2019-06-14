#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests
@test 'Check smb.conf' {
  run bash -c "docker exec -ti ${SUT_ID} cat /etc/samba/smb.conf"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ "[foo]" ]]
  [[ "${output}" =~ "path = /tmp/foo" ]]
  [[ "${output}" =~ "[bar]" ]]
  [[ "${output}" =~ "path = /tmp/bar" ]]
}

@test 'Check testparm' {
  run bash -c "docker exec -ti ${SUT_ID} testparm -s"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ "Loaded services file OK" ]]
}

