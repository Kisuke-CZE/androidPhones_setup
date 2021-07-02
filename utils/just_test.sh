#!/bin/bash
SCRIPT_LOCATION="$(dirname $(readlink -f "${0}"))"

echo "Detected vendor: ${VENDOR}"
echo "Detected model: ${MODEL}"

if [ -z "${VENDOR}" ] || [ -z "${MODEL}" ]
then
  echo "Cannot continue. Vendor and phone model was not specified"
  exit 1
fi


if [ ! -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable" ] && [ ! -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall" ]
then
  echo "Cannot find setup for ${VENDOR} - ${MODEL}."
  exit 1
fi

ADB_CMD="$(which adb)"
if [ -z "${ADB_CMD}" ]
then
  echo "ADB is not installed. Please install it."
  echo "  On Debian/Ubuntu based distibution, just do: sudo apt install adb fastboot"
  exit 1
fi
ADB_DEVICES="$(adb devices | sed '/List of devices attached/d')"
if [ -z "${ADB_DEVICES}" ]
then
  echo "No ADB devices connected."
  echo "  Please connect your phone. Also check that USB Debugging is enabled in settings and computer is authorized to connect your phone."
  exit 1
fi

if [ -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall" ]
then
  echo -e "\nPackages to uninstall:"
  cat "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall"
fi

if [ -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable" ]
then
  echo -e "\nPackages to disable:"
  cat "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable"
fi
