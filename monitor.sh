#!/bin/bash
# Script to create xrandr profiles for two 1440x900 monitors.
#
#TO DO: 
#Problem with --addmode after multiple uses of script. 


echo "Available monitors:"
MONITOR1=$(xrandr | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | cut -d$'\n' -f 1)
MONITOR2=$(xrandr | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | cut -d$'\n' -f 2)
declare -i mode=0

echo "1. $MONITOR1"
echo "2. $MONITOR2"

while true; do
	read -p "Which monitor would you like to work on?" ot
	case $ot in 
		[1]* ) mode=$((mode + 1)); break;;
		[2]* ) mode=$((mode + 2)); break;;
		* ) echo "Please answer 1 for first, 2 for second.";;
	esac
done

echo "Enter desired resolution in format: width height refresh. E.g 1440 900 60"
read input_variable
echo "You entered: $input_variable"
MODENAME=$"NAMESTRING_1234"
CVT="$(cvt $input_variable)"
MODELINE=$(echo $CVT| cut -d '"' -f 3)

sudo xrandr --newmode \"$MODENAME\" $MODELINE

if (( $mode == 1 )) ; then
	sudo xrandr --addmode $MONITOR1 $MODENAME
elif (( $mode == 2 )) ; then
	sudo xrandr --addmode $MONITOR2 $MODENAME
else 
	echo "Invalid mode type."
fi






