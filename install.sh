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

if [ -d /usr/local/bin/jsconnect-dir ]; then
    echo "The directory /usr/local/bin/jsconnect-dir already exist"
    echo "Check this up!"
    exit 1
else
    if [ -e /usr/local/bin/jsconnect ]; then
        echo "The file/link  /usr/local/bin/jsconnect already exists"
        echo "Check this up"
        exit 1
    else
        mkdir /usr/local/bin/jsconnect-dir
        cp $THISDIR/jsconnect.sh /usr/local/bin/jsconnect-dir/
        chmod 755 /usr/local/bin/jsconnect-dir/jsconnect.sh
        ln -s jsconnect-dir/jsconnect.sh /usr/local/bin/jsconnect
    fi
fi

if [ -d /etc/jsconnect ]; then
    echo "Directory /etc/jsconnect exists"
else
    mkdir /etc/jsconnect
fi

echo

if [ -e /etc/jsconnect/jsconnect.conf ]; then
    echo "Configuration file already exists."
    echo "Do you wish to overwrite it?"
    select OVERWRITE1 in yes no
    do
        break
    done
else 
    cp $THISDIR/jsconnect.conf /etc/jsconnect/jsconnect.conf
    chmod a+r /etc/jsconnect/jsconnect.conf
fi

if [ $OVERWRITE1="yes" ]; then
    cp $THISDIR/jsconnect.conf /etc/jsconnect/jsconnect.conf
    chmod a+r /etc/jsconnect/jsconnect.conf
else
    cp $THISDIR/jsconnect.conf /etc/jsconnect/jsconnect.conf.$TIME
    echo
    echo "A copy of the new configuration file is located at /etc/jsconnect/jsconnect.conf.$TIME"
fi

echo

if [ -e /etc/jsconnect/jsconnect.computers ]; then
    echo "Computers file already exists."
    echo "Do you wish to overwrite it?"
    select OVERWRITE2 in yes no
    do
        break
    done
else
    cp $THISDIR/jsconnect.computers /etc/jsconnect/jsconnect.computers
    chmod a+r /etc/jsconnect/jsconnect.computers
fi

if [ $OVERWRITE2="yes" ]; then
    cp $THISDIR/jsconnect.computers /etc/jsconnect/jsconnect.computers
    chmod a+r /etc/jsconnect/jsconnect.computers
else
    echo
    cp $THISDIR/jsconnect.computers /etc/jsconnect/jsconnect.computers.$TIME
    echo "A copy of the new conmputers file is located at $HOME/.jsconnect.computers.$TIME"
fi

echo

if [ -e /etc/jsconnect/jsconnect.users ]; then
    echo "Users file already exists."
    echo "Do you wish to overwrite it?"
    select OVERWRITE3 in yes no
    do
        break
    done
else
    cp $THISDIR/jsconnect.users /etc/jsconnect/jsconnect.users
    chmod a+r /etc/jsconnect/jsconnect.users
fi

if [ $OVERWRITE3="yes" ]; then
    cp $THISDIR/jsconnect.users /etc/jsconnect/jsconnect.users
    chmod a+r /etc/jsconnect/jsconnect.users
else
    cp $THISDIR/jsconnect.users /etc/jsconnect/jsconnect.users.$TIME
    echo
    echo "A copy of the new users file is located at $HOME/.jsconnect.users.$TIME"
fi

echo

if [ -d /usr/local/bin/jsconnect-dir ]; then
    if [ -x /usr/local/bin/jsconnect-dir/jsconnect.sh ]; then
        if [ -h /usr/local/bin/jsconnect ]; then
            echo "Install successful"
            echo "Run with jsconnect"
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
