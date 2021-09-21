#!/bin/bash

while :
do
  sleep 10
  mkdir -p /home/container/stall-reports
  pid=$(jcmd | grep "[0-9] java *" | awk '{print $1}')
  jcmd $pid Thread.print > "/home/container/stall-reports/stall_report_$(date +"%Y-%m-%d_%H.%M.%S")"
done
