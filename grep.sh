grep -h Settings *.txt | cut --delimiter=: --fields=2 | awk 'p{print $0-p}{p=$0}'

cat settings.log | cut --delimiter=: --fields=2,3 > cut.log

