#!/bin/bash

repocnf="/etc/apt/sources.list.d/percona-release.list"

grep ^VERSION= /etc/os-release
echo "-----"

process_repo() {
  repo="$1";
  for r in "main" "testing" "experimental"; do
    if [ "${r}" != "${repo}" ]; then
      sed -Ei "s/^#*(.*${r}\$)/#\\1/" "${repocnf}" > /dev/null 2>&1
    else
      sed -Ei "s/^#*(.*${r}\$)/\\1/" "${repocnf}" > /dev/null 2>&1
    fi
  done
  apt-get update > /dev/null 2>&1
  lz4cat "/var/lib/apt/lists/repo.percona.com_apt_dists_bionic_${repo}_binary-amd64_Packages.lz4" \
    | grep '^Package:' \
    | while read -r line; do echo -e "\t$line"; done
}

# main

echo "Experimental packages:"
process_repo "experimental"

echo "Testing packages:"
process_repo "testing"

echo "Main packages:"
process_repo "main"

# command hook

# I want array expansions so please 
# shellcheck disable=SC2068
[ "$1" != "" ] && $@
