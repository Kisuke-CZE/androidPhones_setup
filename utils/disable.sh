#!/bin/bash
cannot_disable=""
while read line
do
  result=$(adb </dev/null shell pm uninstall -k --user 0 "${line}" 2>&1)
  if [ $? -eq 0 ]
  then
    echo "Package ${line} disabled succesfully"
  else
    cannot_disable="${cannot_disable}${line}: ${result}\n\n"
  fi
done < "${1}"

echo
echo "These packages cannot be disabled (see reason after package name):"
echo -e "${cannot_disable}"
