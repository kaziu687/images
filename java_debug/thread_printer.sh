#!/bin/bash

while :
do
  sleep 10
  mkdir -p /home/container/stall-reports
  pid=$(ps ax | grep -i "java " | awk 'NR==1{print $1}')
  jcmd $pid Thread.print > "/home/container/stall-reports/stall_$(date +"%Y-%m-%d_%H.%M.%S")"
done
