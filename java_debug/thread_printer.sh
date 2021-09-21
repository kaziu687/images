#!/bin/bash

re='^[0-9]+$'
if ! [[ $IBC_DEBUG_STALL_REPORT_INTERVAL_SECONDS =~ $re ]]; then
  IBC_DEBUG_STALL_REPORT_INTERVAL_SECONDS=10
fi

printf "\033[1m\033[33m[BedrockHost.pl - debug]: \033[0mUruchamianie Thread dumpera...\n"
printf "\033[1m\033[33m[BedrockHost.pl - debug]: \033[0mIBC_DEBUG_STALL_REPORT_INTERVAL_SECONDS=%s\n" "$IBC_DEBUG_STALL_REPORT_INTERVAL_SECONDS"

while :
do
  sleep $IBC_DEBUG_STALL_REPORT_INTERVAL_SECONDS
  mkdir -p /home/container/stall-reports
  pid=$(ps ax | grep -i "java " | awk 'NR==1{print $1}')
  jcmd $pid Thread.print > "/home/container/stall-reports/stall_$(date +"%Y-%m-%d_%H.%M.%S")"
done
