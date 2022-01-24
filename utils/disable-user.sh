#!/bin/bash
cannot_uninstall=""
while read line
do
  result=$(timeout 5 adb </dev/null shell pm disable-user "${line}" 2>&1)
  if [ $? -eq 0 ]
  then
    echo "Package ${line} disabled succesfully"
  else
    cannot_uninstall="${cannot_uninstall}${line}\n"
  fi
done < "${1}"


echo
echo "These packages cannot be disabled:"
echo -e "${cannot_uninstall}"
