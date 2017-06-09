# /bin/bash

  # Path to the addn-hosts file
  HOSTS_FILE=./hosts
  
  echo -e "# /etc/hosts auto-generated by $0 \n"> $HOSTS_FILE
  for CNAME in `docker ps |awk '$NF !~/^NAMES$/ && $NF !~/^host[0-9]$/ && $NF !~/-server$/ {print $NF}'`; do
      IP=`docker exec $CNAME ifconfig |grep "inet addr:" |awk ' /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {print $2}' | awk -F":" ' /^addr:10\./ {print $2; exit}'`
      NAME=$CNAME
      echo "$IP    $NAME" >> $HOSTS_FILE
  done;