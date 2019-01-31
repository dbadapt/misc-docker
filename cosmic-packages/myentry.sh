#!/bin/bash

grep ^VERSION= /etc/os-release
echo "-----"

process_repo() {
  repo="$1"
  component="$2"
  internal_repo="${repo}"
  internal_component="${component}"
  [ "${repo}" = "original" ] && internal_repo="percona"
  [ "${component}" = "release" ] && internal_component="main"
  percona-release enable-only "${repo}" "${component}" > /dev/null 2>&1
  apt-get update > /dev/null 2>&1
  packages_file="/var/lib/apt/lists/repo.percona.com_${internal_repo}_apt_dists_cosmic_${internal_component}_binary-amd64_Packages.lz4"
  [ -e ${packages_file} ] && ( \
    lz4cat "/var/lib/apt/lists/repo.percona.com_${internal_repo}_apt_dists_cosmic_${internal_component}_binary-amd64_Packages.lz4" \
      | grep '^Package:' \
      | while read -r line; do echo -e "\t$line"; done
  )
}

# main

for repo in "original" "ps-80" "pxc-80" "psmdb-40" "tools"
do
  for component in "experimental" "testing" "release"
  do
    echo "${repo} ${component} packages:"
    process_repo "${repo}" "${component}"
  done
done

# command hook

# I want array expansions so please 
# shellcheck disable=SC2068
[ "$1" != "" ] && $@
