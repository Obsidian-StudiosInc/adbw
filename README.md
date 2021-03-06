# adbw.sh
[![License](https://img.shields.io/badge/license-GPLv3-blue.svg?colorB=9977bb&style=plastic)](https://github.com/Obsidian-StudiosInc/adbw/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/Obsidian-StudiosInc/adbw/master.svg?colorA=9977bb&style=plastic)](https://travis-ci.org/Obsidian-StudiosInc/adbw)
[![Build Status](https://img.shields.io/shippable/5840e5d7e2ab4d0f0058b4b1/master.svg?colorA=9977bb&style=plastic)](https://app.shippable.com/projects/5840e5d7e2ab4d0f0058b4b1/)

adb wrapper script to run adb against multiple devices. See the following 
examples for usage

## Examples
Each of the following will launch a new konsole window per device. 
Presently using konsole in KDE but can be modified for other.

Example use for commands
```shell
adbw.sh -t logcat
adbw.sh -t shell
```

Or you can use in a script such as the following example.

Example use in script
```shell
#!/bin/bash
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Sample to build, then push an app to all attached devices :)

build() {
        ./gradlew clean
        ./gradlew build
}

push() {
	# Sourcing is best as it keeps all devices in variables
	# Alternatively add adbw.sh to PATH env variable ( slower )
        source /home/wlt/scripts/adbw.sh

        adbw shell am force-stop com.android.app
        adbw shell pm clear com.android.app
        adbw uninstall com.android.app
        adbw install app/build/outputs/apk/app-debug.apk
}

if [[ "${1}" ]]; then
        "${1}"
else
        build
        push
fi

```

