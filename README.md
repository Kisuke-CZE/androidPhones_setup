# androidPhones_setup
Simple setup scripts for my phones with Android to get rid of preinstalled bloatware without root access needed

# Requirements
Whole thing is only simple bash script. But it uses `adb` tool to talk to phone.

In Ubuntu/Debian flavored Linux, you can install adb with: `sudo apt install android-tools-adb android-tools-fastboot`

You also need to enable USB Debugging in your phone.

# Usage
Just clone this repository and run `prepare_phone.sh` in it's root directory which will try to autodetect your phone model and launch setup for it if it's defined.

If you use this script to setup AndroidTV box, you must find your device IP address in local network and then run `adb connect ATV_BOX_IP_ADDRESS:5555`.

Same thing applies for using with Amazon's FireTV devices like FireTV Cube. But since FireTV devices requires special approach, use `prepare_firetv.sh` instead.

If you want to create script/preset for your phone, jus create corresponding structure in `devices` directory. Structure should be `VENDOR/MODEL`.

You can find correct values of `VENDOR` and `MODEL` which your phone reports by running `prepare_phone.sh test`

In phone model specific directory, you can create files:

| Filename           | What it does                                                                                                               |
| ------------------ |----------------------------------------------------------------------------------------------------------------------------|
| `uninstall`        | Script will try to uninstall package from phone completely (if it fails, I suggest to try it uninstall package for user 0) |
| `uninstall.extras` | Same as uninstall, but does not uninstall packages automatically - it just suggests user to run a command to uninstall those packages. |
| `disable`        | Script will try to disable package for user `0` - which is usually default user |
| `disable.extras` | Same as disable, but does not disable packages automatically - it just suggests user to run a command to disable those packages. |
| `NOTES`   | Just a message to user which will be shown at the end of phone setup process - good place where to put some model specific warnings (which packages bricks the phone and stuff like that) |

# Identifying package names
If you wonder how to identify those package names for unwanted apps in your phone - try [App Inspector](https://play.google.com/store/apps/details?id=bg.projectoria.appinspector) or [AppChecker](https://play.google.com/store/apps/details?id=com.kroegerama.appchecker)
