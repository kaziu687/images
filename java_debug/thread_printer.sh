#!/bin/bash

while :
do
  sleep 10
  mkdir -p /home/container/stall-reports
  #pid=$(jcmd -l | grep "[0-9] java *" | awk '{print $1}')
  pid=1
  jcmd $pid Thread.print > "/home/container/stall-reports/stall_$(date +"%Y-%m-%d_%H.%M.%S")"
done
