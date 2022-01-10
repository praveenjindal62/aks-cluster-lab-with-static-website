#!/bin/sh
n=-1
c=0
if [ $# -lt 2 ]
then
   echo "Insufficient arguments provided. Expected two arguments"
   exit 1
fi
if [ -n "$3" ]
then
   n=$3
fi
HOSTNAME=`hostname`
if [ "$LOG_DIR" = "" ]
then 
   LOG_PATH=/proc/self/fd/1
else
   #LOG_DIR=`dirname $LOG_PATH`
   if ! ls $LOG_DIR > /dev/null 2>&1
   then
      mkdir -p $LOG_DIR
      if [ $? -ne 0 ]
      then
         echo "Could not create directory $LOG_DIR."
         exit 1 
      fi 
   fi
   LOG_PATH=$LOG_DIR/system.$HOSTNAME.log
   echo "Logs will be captured in file " $LOG_PATH > /proc/self/fd/1
fi 
while [ $n -ne $c ]
do
   WAIT=$(shuf -i $1-$2 -n 1)
   sleep $(echo "scale=4; $WAIT/1000" | bc)
   I=$(shuf -i 1-4 -n 1)
   D=`date '+%F %X #~'`
   case "$I" in
      "1") echo "$D ERROR An error is usually an exception that has been caught and not handled." >> $LOG_PATH
      ;;
      "2") echo "$D INFO This is less important than debug log and is often used to provide context in the current task." >> $LOG_PATH
      ;;
      "3") echo "$D WARN A warning that should be ignored is usually at this level and should be actionable." >> $LOG_PATH
      ;;
      "4") echo "$D DEBUG This is a debug log that shows a log that can be ignored." >> $LOG_PATH
      ;;
   esac
   c=$(( c+1 ))
done
