#!/bin/bash

export APACHE_RUN_USER=snap_daemon
export APACHE_RUN_GROUP=snap_daemon
export APACHE_RUN_DIR=/var/apache2/run
export APACHE_LOCK_DIR=/var/apache2/lock
export APACHE_LOG_DIR=/var/apache2/log
export APACHE_PID_FILE=/var/apache2/run/apache2.pid
export HTTP_PORT="$(snapctl get ports.http)"
export HTTPS_PORT="$(snapctl get ports.https)"
export SSL_ENABLED="$(snapctl get ssl.enabled)"
export SSL_CERT="$(snapctl get ssl.cert)"
export SSL_KEY="$(snapctl get ssl.key)"

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
  $SNAP/usr/sbin/apache2 -k graceful
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

no_args="true"
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
   no_args="false"
done

if [[ "$no_args" == "true" ]] ; then
  display_help
fi
