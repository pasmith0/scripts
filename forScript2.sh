#!/bin/bash

IP_LIST="10.143.5.1
10.143.5.2
10.143.5.3
10.143.5.4
10.143.5.5"

for i in $IP_LIST 
 do echo Processing $i 
 java -jar /c/depot/settop/atlas/tools/dvr_parser/parse_DVR.jar $i
 mv rec2.csv $i.csv
done



