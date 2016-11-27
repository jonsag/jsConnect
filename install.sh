#!/bin/bash

THISDIR=$(dirname $0)
TIME=$(date +%y%m%d-%H:%M:%S)

if [ $(whoami) = "root" ]
then
  echo "You are root, and can install this script"
  echo
else
  echo "You must be root to install"
  echo "Exiting"
  exit 1
fi

if [ -d /usr/local/bin/shconnect-dir ]; then
    echo "The directory /usr/local/bin/shconnect-dir already exist"
    echo "Check this up!"
    exit 1
else
    if [ -e /usr/local/bin/shconnect ]; then
        echo "The file/link  /usr/local/bin/shconnect already exists"
        echo "Check this up"
        exit 1
    else
        mkdir /usr/local/bin/shconnect-dir
        cp $THISDIR/shconnect.sh /usr/local/bin/shconnect-dir/
        chmod 755 /usr/local/bin/shconnect-dir/shconnect.sh
        ln -s shconnect-dir/shconnect.sh /usr/local/bin/shconnect
    fi
fi

if [ -d /etc/shconnect ]; then
    echo "Directory /etc/shconnect exists"
else
    mkdir /etc/shconnect
fi

echo

if [ -e /etc/shconnect/shconnect.conf ]; then
    echo "Configuration file already exists."
    echo "Do you wish to overwrite it?"
    select OVERWRITE1 in yes no
    do
        break
    done
else 
    cp $THISDIR/shconnect.conf /etc/shconnect/shconnect.conf
    chmod a+r /etc/shconnect/shconnect.conf
fi

if [ $OVERWRITE1="yes" ]; then
    cp $THISDIR/shconnect.conf /etc/shconnect/shconnect.conf
    chmod a+r /etc/shconnect/shconnect.conf
else
    cp $THISDIR/shconnect.conf /etc/shconnect/shconnect.conf.$TIME
    echo
    echo "A copy of the new configuration file is located at /etc/shconnect/shconnect.conf.$TIME"
fi

echo

if [ -e /etc/shconnect/shconnect.computers ]; then
    echo "Computers file already exists."
    echo "Do you wish to overwrite it?"
    select OVERWRITE2 in yes no
    do
        break
    done
else
    cp $THISDIR/shconnect.computers /etc/shconnect/shconnect.computers
    chmod a+r /etc/shconnect/shconnect.computers
fi

if [ $OVERWRITE2="yes" ]; then
    cp $THISDIR/shconnect.computers /etc/shconnect/shconnect.computers
    chmod a+r /etc/shconnect/shconnect.computers
else
    echo
    cp $THISDIR/shconnect.computers /etc/shconnect/shconnect.computers.$TIME
    echo "A copy of the new conmputers file is located at $HOME/.shconnect.computers.$TIME"
fi

echo

if [ -e /etc/shconnect/shconnect.users ]; then
    echo "Users file already exists."
    echo "Do you wish to overwrite it?"
    select OVERWRITE3 in yes no
    do
        break
    done
else
    cp $THISDIR/shconnect.users /etc/shconnect/shconnect.users
    chmod a+r /etc/shconnect/shconnect.users
fi

if [ $OVERWRITE3="yes" ]; then
    cp $THISDIR/shconnect.users /etc/shconnect/shconnect.users
    chmod a+r /etc/shconnect/shconnect.users
else
    cp $THISDIR/shconnect.users /etc/shconnect/shconnect.users.$TIME
    echo
    echo "A copy of the new users file is located at $HOME/.shconnect.users.$TIME"
fi

echo

if [ -d /usr/local/bin/shconnect-dir ]; then
    if [ -x /usr/local/bin/shconnect-dir/shconnect.sh ]; then
        if [ -h /usr/local/bin/shconnect ]; then
            echo "Install successful"
            echo "Run with shconnect"
        else
            echo "Install unsuccessful"
            echo "No link created"
            exit 1
        fi
     else
        echo "Install unsuccessful"
        echo "No executable file created"
        exit 1
     fi
else
    echo "Install unsuccessful"
    echo "No directory created"
    exit 1
fi
