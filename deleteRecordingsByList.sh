#!/bin/bash

if [ $# -ne 2 ] ; then
  echo Usage: delete_recordings_by_list IP_ADDR file
  echo Must enter both options.
  echo File is a list of recordings to delete.
  exit 1
fi

# The multiple delete URI is a PUT to http://ipaddr:8092/sl/dvr/manage/multiple_delete
# The data portion of the request contains the recordings to delete.
#
# The input file is a text file where each line has title tab-separated by uniqueID.
#

IP_ADDR=$1
INPUTFILE=$2
IFS=$'\t' ; 
while read name id ; 
  do echo -e "\nDeleting recording" \"$name\" Unique id $id ... ; 
  # remove the -s for debugging
  curl -s http://$IP_ADDR:8092/sl/dvr/manage/multiple_delete -XPUT --header "Content-Type: application/json" --header "guid: 1234" --data "{ \"recordingsToDelete\" : [ \"$id\" ] }" ; 
done < "$INPUTFILE";


