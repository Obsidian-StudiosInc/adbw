#!/bin/bash
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Run adb commands against all attached devices :)

# Start adb before we load devices
[[ -z "$( pgrep -x adb )" ]] && adb start-server

# Load devices
DEVICES=($( adb devices ))

# Default output is 4 array entries
SKIP=4

# Check for devices
if [[ ${#DEVICES[@]} -le ${SKIP} ]]; then
	echo "No devices found"
	exit 1
fi

# Number of devices
let COUNT=${#DEVICES[@]}-${SKIP}

# Skip first 4, devices start after that
DEVICES=( ${DEVICES[@]:${SKIP}} )

# Wrap adb with the arguments passed
adbw() {
	if [[ ! $1 ]]; then
		echo "Nothing to pass to adb"
		return 1
	fi

	local i=0
	while [[ ${i} < ${COUNT} ]]; do
		adb_cmd="/usr/bin/adb -s ${DEVICES[${i}]} ${*:1}"
		if [[ ${1} == "-t" ]]; then
			# wrapper needed since konsole -e broken
			# passes on any - options to konsole not command :(
			tmp_file="/tmp/adb_${DEVICES[${i}]}.sh"
			echo -e "#!/bin/bash \\n ${adb_cmd}" > "${tmp_file}"
			chmod 775 "${tmp_file}"
			konsole -e "${tmp_file}" &
		else
			echo ${adb_cmd}
			${adb_cmd}
		fi
		let i+=2;
	done
}

[[ "${0: -7}" == "adb+.sh" ]] && adb+ ${@:2}
