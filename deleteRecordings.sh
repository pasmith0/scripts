#!/bin/bash

if [ $# -ne 2 ] ; then
  echo "Usage: delete_recordings IP_ADDR [GET | DELETE]"
  echo Must enter both options.
  exit 1
fi

if [ $2 == "GET" ] ; then
  echo GET
else 
  if [ $2 == "DELETE" ] ; then
    echo DELETE
  else
    echo Option must be GET or DELETE
    exit 1
  fi
fi

IP_ADDR=$1
OPTION=$2
OUTPUT_FILE='recording_list.txt'

echo Getting recordings from settop $IP_ADDR...

# Get the recordings from the settop and output the html file to recordings.html
# Remove the -q for debugging
wget -q http://$IP_ADDR/RecordingInfo?currentshowsbydate -O recordings.html

# Parse the HTML and produce list of recordings 
awk '{ gsub("<tr>", "\n"); print$0; }' recordings.html |  awk -F "</*td>" '/<\/*t[td]>.*[A-Z][A-Z]/ {print $4 "\t" $20}' > $OUTPUT_FILE

# Don't need this file anymore
rm recordings.html

if [  ! -s $OUTPUT_FILE ]; then 
  echo No recordings found
else
  cat $OUTPUT_FILE
fi

if [ ! $OPTION == "DELETE" ] ; then
  exit 0
fi


# The multiple delete URI is a PUT to http://ipaddr:8092/sl/dvr/manage/multiple_delete
# The data portion of the request contains the recordings to delete.
#
# The input file is a text file where each line has title tab-separated by uniqueID.
#

input=$OUTPUT_FILE ; 
IFS=$'\t' ; 
while read name id ; 
  do echo -e "\nDeleting recording" \"$name\" Unique id $id ... ; 
  # remove the -s for debugging
  curl -s http://$IP_ADDR:8092/sl/dvr/manage/multiple_delete -XPUT --header "Content-Type: application/json" --header "guid: 1234" --data "{ \"recordingsToDelete\" : [ \"$id\" ] }" ; 
done < "$input";


