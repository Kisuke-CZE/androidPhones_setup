#!/bin/bash
cannot_reinstall=""
while read line
do
  result=$(adb </dev/null shell cmd package install-existing "${line}" 2>&1)
  if [ $? -eq 0 ]
  then
    echo "Package ${line} reinstalled succesfully"
  else
    cannot_reinstall="${cannot_reinstall}${line}\n"
  fi
done < "${1}"


echo
echo "These packages cannot be reinstalled:"
echo -e "${cannot_reinstall}"
