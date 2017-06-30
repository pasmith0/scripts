#!/bin/bash
shopt -s nullglob

if [ $# -eq 0 ] ; then
echo "Usage: must enter file to find (wildcards are good)"
exit 1
fi

todayd=`date "+%Y-%m-%d"`
tomorrowd=`date --date="-1 days ago" "+%Y-%m-%d"`
#echo today is $todayd tomorrow is $tomorrowd
echo param is "$*"

find . -type f -iname "$*" -newermt $todayd ! -newermt $tomorrowd -printf "%f\t\t\t%Ac\n"

