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

service_start() {
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
    https_enable
  fi

  if [[ $SSL_ENABLED == 'false' ]] ; then
    https_disable
  fi

  $SNAP/usr/sbin/apache2 -k start $SSL_FLAG
}

service_stop() {
  $SNAP/usr/sbin/apache2 -k stop
}

service_reload() {
  $SNAP/usr/sbin/apache2 -k graceful $SSL_FLAG
}

service_restart() {
  $SNAP/usr/sbin/apache2 -k restart $SSL_FLAG
}

https_enable() {
  export SSL_FLAG="-D SSLEnabled"
}

https_disable() {
  export SSL_FLAG=""
}

while getopts "hs:t:" option; do
   case $option in
      h) # Display help
         display_help
         exit;;
      s) # Service control
         if [[ $OPTARG == "start" ]] ; then
           service_start
         elif [[ $OPTARG == "stop" ]] ; then
           service_stop
         elif [[ $OPTARG == "reload" ]] ; then
           service_reload
         elif [[ $OPTARG == "restart" ]] ; then
           service_restart
         fi
         ;;
      t) # Enable or disable HTTPS
         if [[ $OPTARG == "enable" ]] ; then
           https_enable
         elif [[ $OPTARG == "disable" ]] ; then
           https_disable
         fi
         ;;
     \?) # Display error
         echo "Error: Invalid option"
         exit;;
   esac
done
