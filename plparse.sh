#!/bin/sh
# Script to extract values from PList files based on keys supplied in command line args.
DONE=false
COUNTER=0
filePath=$1
argsArray=( "$@" )
keyArray=("${argsArray[@]:1}")
until $DONE ;do
  OUTPUTS=()
  for key in "${keyArray[@]}" #Check supplied keys.
    do
      #Use PlistBuddy to access given element.
      ELEMENT=$(/usr/libexec/PlistBuddy -c "Print $COUNTER:$key" $filePath 2>/dev/null)
      OUTPUTS+=("$ELEMENT")
    done
  #Check if error, else print a row.
  for key in "${OUTPUTS[@]}"
    do
      if [[ "$key" == "" ]];
      then
      DONE=true
    fi
  done
  echo "${OUTPUTS[*]}"
let COUNTER=COUNTER+1
done
