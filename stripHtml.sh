#!/bin/bash
sed 's/<[^>]*>//g' $1 | sed 's/\&amp;/\&/g'  | sed "s/\&#39;/\’/g"
#another way
#sed '/</ {:k s/<[^>]*>//g; /</ {N; bk}}' $1

