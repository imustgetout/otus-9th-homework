#!/bin/bash
echo -e "PID\tTTY\tSTAT\tTIME\tCOMMAND"
for var in $(ls /proc/|egrep [[:digit:]]|sort -n)
do
echo -e -n "$var\t"
termin='?'
if [ -h /proc/$var/fd/0 ]
then
        if [ -c $(readlink /proc/$var/fd/0) ]
        then
        termi=$(readlink /proc/$var/fd/0)
                if [ $termi != '/dev/null' ]
                then
                termin=$(readlink /proc/$var/fd/0 |cut -c6-10)
                fi
        fi
fi
echo -e -n "$termin\t"
procstat=$(cut -d ' ' -f3 /proc/$var/stat 2>/dev/null)
echo -e -n "$procstat\t"
utime=$(cut -d' ' -f14 /proc/$var/stat 2>/dev/null)
ctime=$(cut -d' ' -f15 /proc/$var/stat 2>/dev/null)
proctime=$(($utime+$ctime))
proctime_min=$(($proctime/100/60))
proctime_sec=$(($proctime/100%60))
echo -e -n "$proctime_min:$proctime_sec\t"
cmdline_length=$(wc -m /proc/$var/cmdline | cut -d' ' -f1)
if [ "$cmdline_length" -gt "0" ]
then
proccommand=$(cat /proc/$var/cmdline)
else
proccommand=$(cat /proc/$var/stat | cut -d' ' -f2)
fi
echo -e "$proccommand"
done