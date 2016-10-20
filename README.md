# adbw.sh
Obsidian-Studios, Inc. Android Script to run adb against multiple 
devices. Which can be further scripted such as the following example.

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
        adbw shell com.android.app
}

if [[ "${1}" ]]; then
        "${1}"
else
        build
        push
fi

```

