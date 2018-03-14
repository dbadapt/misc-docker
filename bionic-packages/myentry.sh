#!/bin/sh

grep ^VERSION= /etc/os-release
echo "-----"

echo "Experimental packages:"
sed -Ei 's/^#*(.* main$)/#\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
sed -Ei 's/^#*(.* testing$)/#\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
sed -Ei 's/^#*(.* experimental$)/\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
apt-get update 2>&1 > /dev/null
lz4cat /var/lib/apt/lists/repo.percona.com_apt_dists_bionic_experimental_binary-amd64_Packages.lz4  | grep '^Package:' | while read line; do /bin/echo -e "\t$line"; done

echo "Testing packages:"
sed -Ei 's/^#*(.* main$)/#\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
sed -Ei 's/^#*(.* testing$)/\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
sed -Ei 's/^#*(.* experimental$)/#\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
apt-get update 2>&1 > /dev/null
lz4cat /var/lib/apt/lists/repo.percona.com_apt_dists_bionic_testing_binary-amd64_Packages.lz4  | grep '^Package:' | while read line; do /bin/echo -e "\t$line"; done


echo "Main packages:"
sed -Ei 's/^#*(.* main$)/\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
sed -Ei 's/^#*(.* testing$)/#\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
sed -Ei 's/^#*(.* experimental$)/#\1/' /etc/apt/sources.list.d/percona-release.list 2>&1 > /dev/null
apt-get update 2>&1 > /dev/null
lz4cat /var/lib/apt/lists/repo.percona.com_apt_dists_bionic_main_binary-amd64_Packages.lz4  | grep '^Package:' | while read line; do /bin/echo -e "\t$line"; done
 


