#!/bin/bash

if [ $# -ne 2 ] ; then
  echo "Usage: delete_series IP_ADDR file"
  echo Must enter an IP address and the command option.
  echo File is a list of series to cancel.
  exit 1
fi

# The cancel series URI is a PUT to http://10.243.66.145:8092/sl/dvr/manage/cancel/{uniqueId}

IP_ADDR=$1
INPUTFILE=$2
IFS=$'\t' ; 
while read name id ; 
  do echo -e "\nDeleting series" \"$name\" Unique id $id ... ; 
  # remove the -s for debugging
  curl -s http://$IP_ADDR:8092/sl/dvr/manage/cancel/$id -XPUT --header "guid: 1234" ; 
done < "$INPUTFILE";


