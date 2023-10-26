#!/bin/bash
# When you call this script, it needs to have these variables initialized:
# VENDOR
# MODEL
SCRIPT_LOCATION="$(dirname $(readlink -f "${0}"))"


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
# echo "${ADB_DEVICES}"

# Start doing something
if [ -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall" ]
then
  source "${SCRIPT_LOCATION}/utils/uninstall.sh" "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall"
fi

if [ -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable" ]
then
  source "${SCRIPT_LOCATION}/utils/disable-user.sh" "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable"
fi

if [ -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall.extras" ]
then
  echo
  echo
  echo "You can uninstall some more extra packages:"
  cat "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall.extras"
  echo
  echo "If you want to do that, run this command:"
  echo "  $(readlink -f "${SCRIPT_LOCATION}/utils/uninstall.sh") $(readlink -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/uninstall.extras") "
fi

if [ -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable.extras" ]
then
  echo
  echo
  echo "You can disable some more extra packages:"
  cat "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable.extras"
  echo
  echo "If you want to do that, run this command:"
  echo "  $(readlink -f "${SCRIPT_LOCATION}/utils/disable-user.sh") $(readlink -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/disable.extras") "
fi

if [ -f "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/NOTES" ]
then
  echo
  echo
  echo "Here are some useful notes for your phone model for future experiments:"
  cat "${SCRIPT_LOCATION}/devices/${VENDOR}/${MODEL}/NOTES"
fi
