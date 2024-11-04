#!/bin/bash

source $SNAP/bin/get-snap-configuration.sh

export APACHE_RUN_USER=snap_daemon
export APACHE_RUN_GROUP=snap_daemon
export APACHE_LOCK_DIR=/tmp/apache2/lock
export APACHE_LOG_DIR=/tmp/apache2/log
export APACHE_RUN_DIR=/tmp/apache2/run
export APACHE_PID_FILE=/tmp/apache2/run/apache2.pid
export HTML="$SNAP/html"

display_help() {
   echo "Usage: $(basename "$0") [-h] [-s start|stop|reload|restart]"
   echo "                             [-t enable|disable]"
   echo
   echo "Options:"
   echo "  -h        : Prints this help message"
   echo "  -s action : Service control"
   echo "  -t action : Enable or disable HTTPS"
}

apache2_start() {
  if [ ! -d /tmp/apache2 ] ; then
    mkdir /tmp/apache2
  fi

  if [ ! -d /tmp/apache2/run ] ; then
    mkdir /tmp/apache2/run
  fi

  if [ ! -d /tmp/apache2/lock ] ; then
    mkdir /tmp/apache2/lock
  fi

  if [ ! -d /tmp/apache2/log ] ; then
    mkdir /tmp/apache2/log
  fi

  if [[ $SSL_ENABLED == 'true' ]] ; then
    enable_https
  fi

  if [[ $SSL_ENABLED == 'false' ]] ; then
    disable_https
  fi

  $SNAP/usr/sbin/apache2 -k start $SSL_FLAG
}

apache2_stop() {
  $SNAP/usr/sbin/apache2 -k stop
}

apache2_reload() {
  $SNAP/usr/sbin/apache2 -k graceful $SSL_FLAG
}

apache2_restart() {
  $SNAP/usr/sbin/apache2 -k restart $SSL_FLAG
}

enable_https() {
  export SSL_FLAG="-D SSLEnabled"
}

disable_https() {
  export SSL_FLAG=""
}

while getopts "hs:t:" option; do
   case $option in
      h) # Display help
         display_help
         exit;;
      s) # Service control
         if [[ $OPTARG == "start" ]] ; then
           apache2_start
         elif [[ $OPTARG == "stop" ]] ; then
           apache2_stop
         elif [[ $OPTARG == "reload" ]] ; then
           apache2_reload
         elif [[ $OPTARG == "restart" ]] ; then
           apache2_restart
         fi
         ;;
      t) # Enable or disable HTTPS
         if [[ $OPTARG == "enable" ]] ; then
           enable_https
         elif [[ $OPTARG == "disable" ]] ; then
           disable_https
         fi
         ;;
     \?) # Display error
         echo "Error: Invalid option"
         exit;;
   esac
done
