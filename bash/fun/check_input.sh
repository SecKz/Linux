#!/bin/sh
#
function check_input {
  message=$1
  validate=$2
  default=$3

  while [ $? -ne 1 ]; do
    echo -n "$message "
    read INPUTTEXT < /dev/tty
    if [ "$INPUTTEXT" == "" -a "$default" != "" ]; then
      INPUTTEXT=$default
      return 1
    fi
    echo $INPUTTEXT | egrep -qi "$validate" && return 1
    echo "Invalid input"
  done

}


check_input "Do you agree to these terms? (yes/no) [Default: yes]" "yes|no" "yes"
echo $INPUTTEXT ++++++++++++++++++
