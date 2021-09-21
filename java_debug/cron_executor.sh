#!/bin/bash

while :
do
  sleep 10
  mkdir -p /home/container/stall-reports
  jcmd -l > "/home/container/stall-reports/jcmd_$(date +"%Y-%m-%d_%H.%M.%S")" 2> "/home/container/stall-reports/jcmd_$(date +"%Y-%m-%d_%H.%M.%S")_error"
  pid=$(jcmd -l | grep "[0-9] java *" | awk '{print $1}')
  jcmd $pid Thread.print > "/home/container/stall-reports/stall_$(date +"%Y-%m-%d_%H.%M.%S")"
done
