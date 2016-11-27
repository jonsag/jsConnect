#!/bin/bash

if [ $(whoami) = "root" ]
then
  echo "You are root, and can run this script"
  echo
else
  echo "You must be root to uninstall"
  echo "Exiting"
  exit 1
fi

echo "Uninstalling..."
echo

if [ -h /usr/local/bin/shconnect ]; then
   echo "Removing link"
   rm -f /usr/local/bin/shconnect
else
    echo "Link does not exist"
fi

if [ -e /usr/local/bin/shconnect-dir/shconnect.sh ]; then
    echo "Removing script"
    rm -f /usr/local/bin/shconnect-dir/shconnect.sh
else
    echo "Script does not exist"
fi

if [ -d /usr/local/bin/shconnect-dir ]; then
    echo "Removing directory"
    rmdir --ignore-fail-on-non-empty /usr/local/bin/shconnect-dir
else
    echo "Directory does not exist"
fi

echo

if [ -h /usr/local/bin/shconnect ] || [ -e /usr/local/bin/shconnect-dir/shconnect.sh ] || [ -d /usr/local/bin/jscconnect-dir ]; then
    echo "Everything could not be uninstalled"
    echo "Exiting"
    exit 1
else
    echo "Uninstall successful"
fi
