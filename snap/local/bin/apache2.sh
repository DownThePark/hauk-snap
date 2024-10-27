#!/bin/bash

export APACHE_RUN_USER=snap_daemon
export APACHE_RUN_GROUP=snap_daemon
export APACHE_RUN_DIR=/var/apache2/run
export APACHE_LOCK_DIR=/var/apache2/lock
export APACHE_LOG_DIR=/var/apache2/log
export APACHE_PID_FILE=/var/apache2/run/apache2.pid
export HTTP_PORT="$(snapctl get server.ports.http)"

display_help() {
   echo "Usage: $(basename "$0") [-h] [-s start|stop|reload|restart]"
   echo
   echo "Options:"
   echo "  -h        : Prints this help message"
   echo "  -s action : Service control"
}

apache2_start() {
  if [ -z "$HTTP_PORT" ] ; then
    snapctl set server.ports.http=8000
    export HTTP_PORT="$(snapctl get server.ports.http)"
  fi

  if [ ! -d /var/apache2 ] ; then
    mkdir /var/apache2
  fi

  if [ ! -d /var/apache2/run ] ; then
    mkdir /var/apache2/run
  fi

  if [ ! -d /var/apache2/lock ] ; then
    mkdir /var/apache2/lock
  fi

  if [ ! -d /var/apache2/log ] ; then
    mkdir /var/apache2/log
  fi

  $SNAP/usr/sbin/apache2 -k start
}

apache2_stop() {
  $SNAP/usr/sbin/apache2 -k stop
}

apache2_reload() {
  $SNAP/usr/sbin/apache2 -k graceful
}

apache2_restart() {
  $SNAP/usr/sbin/apache2 -k restart
}

no_args="true"
while getopts ":hs:" option; do
   case $option in
      h) display_help
         exit;;
      s) if [ $OPTARG == 'start' ] ; then
           apache2_start
         elif [ $OPTARG == 'stop' ] ; then
           apache2_stop
         elif [ $OPTARG == 'reload' ] ; then
           apache2_reload
         elif [ $OPTARG == 'restart' ] ; then
           apache2_restart
         fi
         ;;
     \?) echo "Error: Invalid option"
         exit;;
   esac
   no_args="false"
done

if [[ "$no_args" == "true" ]] ; then
  display_help
fi
