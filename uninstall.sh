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

if [ -h /usr/local/bin/jsconnect ]; then
   echo "Removing link"
   rm -f /usr/local/bin/jsconnect
else
    echo "Link does not exist"
fi

if [ -e /usr/local/bin/jsconnect-dir/jsconnect.sh ]; then
    echo "Removing script"
    rm -f /usr/local/bin/jsconnect-dir/jsconnect.sh
else
    echo "Script does not exist"
fi

if [ -d /usr/local/bin/jsconnect-dir ]; then
    echo "Removing directory"
    rmdir --ignore-fail-on-non-empty /usr/local/bin/jsconnect-dir
else
    echo "Directory does not exist"
fi

echo

if [ -h /usr/local/bin/jsconnect ] || [ -e /usr/local/bin/jsconnect-dir/jsconnect.sh ] || [ -d /usr/local/bin/jscconnect-dir ]; then
    echo "Everything could not be uninstalled"
    echo "Exiting"
    exit 1
else
    echo "Uninstall successful"
fi
