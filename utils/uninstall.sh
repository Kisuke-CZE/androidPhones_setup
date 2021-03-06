#!/bin/bash
cannot_uninstall=""
while read line
do
  result=$(timeout 5 adb </dev/null uninstall "${line}" 2>&1)
  if [ $? -eq 0 ]
  then
    echo "Package ${line} uninstalled succesfully"
  else
    cannot_uninstall="${cannot_uninstall}${line}\n"
  fi
done < "${1}"


echo
echo "These packages cannot be uninstalled (try to disable them - file disable or disable.extras):"
echo -e "${cannot_uninstall}"
