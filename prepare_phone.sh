#!/bin/bash
VENDOR="$(adb shell getprop ro.product.manufacturer 2>&1)"
if [ ! ${?} -eq 0 ]
then
  echo "Cannot find your phone. Check output of adb shell command:"
  echo "${VENDOR}"
  exit 1
fi
MODEL="$(adb shell getprop ro.product.model 2>&1 | tr ' ' '_')"
VENDOR="${VENDOR,,}"
MODEL="${MODEL,,}"
if [ "${1}" == "test" ]
then
  source "$(dirname "${0}")"/utils/just_test.sh
else
  source "$(dirname "${0}")"/utils/prep_phone.sh
fi
