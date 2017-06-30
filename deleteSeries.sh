#!/bin/bash

if [ $# -ne 2 ] ; then
  echo "Usage: delete_series IP_ADDR [GET | DELETE]"
  echo Must enter an IP address and the command option.
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
OUTPUT_FILE='series_list.txt'

echo Getting series from settop $IP_ADDR...

# Get the series from the settop and output the html file to series.html
# Remove the -q for debugging
wget -q http://$IP_ADDR/RecordingInfo?series -O series.html

# Parse the HTML and produce list of series 
awk '{ gsub("<tr>", "\n"); print$0; }' series.html |  awk -F "</*td>" '/<\/*t[td]>.*[A-Z][A-Z]/ {print $4 "\t" $34}' > $OUTPUT_FILE

# Don't need this file anymore
rm series.html

if [  ! -s $OUTPUT_FILE ]; then 
  echo No series found
else
  cat $OUTPUT_FILE
fi

if [ ! $OPTION == "DELETE" ] ; then
  exit 0
fi

# The cancel series URI is a PUT to http://10.243.66.145:8092/sl/dvr/manage/cancel/{uniqueId}

input=$OUTPUT_FILE ; 
IFS=$'\t' ; 
while read name id ; 
  do echo -e "\nDeleting series" \"$name\" Unique id $id ... ; 
  # remove the -s for debugging
  curl -s http://$IP_ADDR:8092/sl/dvr/manage/cancel/$id -XPUT --header "guid: 1234" ; 
done < "$input";


