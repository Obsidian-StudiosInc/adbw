#!/bin/bash
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Run adb commands against all attached devices :)

DEVICES=($( adb devices ))
SKIP=4

# Number of devices
let COUNT=${#DEVICES[@]}-${SKIP}

# Skip first 4, devices start after that
DEVICES=( ${DEVICES[@]:${SKIP}} )

adbw() {
	if [[ ! $1 ]]; then
		echo "Nothing to pass to adb"
		return 1
	fi

	local i=0
	while [[ ${i} < ${COUNT} ]]; do
		adb_cmd="/usr/bin/adb -s ${DEVICES[${i}]} ${@:1}"
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
