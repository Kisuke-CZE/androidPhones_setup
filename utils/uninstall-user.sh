#!/bin/bash
cannot_uninstall=""
while read line
do
  result=$(timeout 5 adb </dev/null shell pm uninstall -k --user 0 "${line}" 2>&1)
  if [ $? -eq 0 ]
  then
    echo "Package ${line} uninstalled succesfully"
  else
    cannot_uninstall="${cannot_uninstall}${line}\n"
  fi
done < "${1}"


echo
echo "These packages cannot be uninstalled (you need to disable them - file disable):"
echo -e "${cannot_uninstall}"
