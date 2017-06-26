#!/bin/sh
# /home/html/find/inotifywait.sh &
# grep -q '^/home/html/find/inotifywait.sh &' /etc/rc.local || echo "/home/html/find/inotifywait.sh &" >> /etc/rc.local


src=/home/html/tgfiles
inotifywait -e modify,delete,create,move  $src | while read files
do
cd /home/html/tgfiles; find . > /home/tgindex.txt; sed -i 's/.\///' /home/tgindex.txt
done