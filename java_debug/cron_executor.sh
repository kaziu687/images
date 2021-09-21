#!/bin/bash
mkdir -p /home/container/stall-reports

sleep 60
jcmd
pid=$(jcmd | grep "[0-9] java *" | awk '{print $1}')
echo pid

if [ -z ${pid+x} ]; then
  echo "PID unset!"
else
  jcmd $pid Thread.print > "/home/container/stall-reports/stall_report_$(date +"%Y-%m-%d_%H.%M.%S")"
fi
