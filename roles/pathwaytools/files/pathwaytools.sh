#!/bin/bash

#save this script in this folder /mnt/gvl/apps/scripts/
SCREEN="/usr/bin/screen"

PTOOLSARGS="-m -d /mnt/gvl/apps/pathwaytools/pathway-tools -www -www-publish all"
export CWEST_TEMP=/mnt/gvl/tmp/ptools_temp

PIDFILE1=/tmp/pathwaytools.pid
PIDFILE2=/tmp/pathwaytools_runtime.pid
case "$1" in
  start)
    echo -n "Starting pathway tools"
    if [[ -f $PIDFILE1 && -f $PIDFILE2 ]];
    then
        echo ""
        echo  "the pathway tools is running!"
        echo "check and remove PID files in /tmp"
        exit 0
    fi
    start-stop-daemon --start --quiet --pidfile $PIDFILE1 --make-pidfile --background --exec $SCREEN -- $PTOOLSARGS
    sleep 1
    PID1=`ps aux | grep "pathway-tools" | grep -v grep | grep -v "pathway-tools-runtime" | awk '{print $2}'`
    sleep 1
    PID2=`ps aux | grep "pathway-tools" | grep -v grep | grep "pathway-tools-runtime" | awk '{print $2}'`
    echo $PID1 > $PIDFILE1
    echo $PID2 > $PIDFILE2
    echo "."
    ;;
  stop)
    echo -n "Stopping pathway tools"
    start-stop-daemon --stop --quiet --pidfile ${PIDFILE1}
    if [[ -f ${PIDFILE2} ]];
    then
      kill -9 $(cat ${PIDFILE2})
      rm ${PIDFILE2}
    fi

    if [[ -f ${PIDFILE1} ]];
        then
            rm ${PIDFILE1}
    fi
    echo "."
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  *)
        echo "Usage: ./pathwaytools.sh {start|stop|restart}"
        exit 1
esac

exit 0
