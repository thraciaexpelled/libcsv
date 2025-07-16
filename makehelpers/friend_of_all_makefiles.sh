#!/usr/bin/env bash

set -e

function return_enduser_os {
	case $(uname) in
		"Linux")
			if [[ ! -z ` $(ls /bin | shuf -n 1) | grep "GNU" ` ]]; then
				echo "GNU/Linux"
			elif [[ ! -z ` $(ls /bin | shuf -n 1) | grep "Busybox" ` ]]; then
				echo "Non-GNU/Linux"
			fi
		;;
		"Darwin")
			echo "Mac OS X"
		;;
		*)
			if [[ ! -z $(uname | grep -e "BSD$") ]]; then
				echo "A BSD"
			else
				echo "Unknown"
			fi
		;;
	esac
}

function return_dylib_file_format {
	case $(return_enduser_os) in
		"GNU/Linux" | "Non-GNU/Linux" | "A BSD")
			echo ".so"
		;;
		"Darwin")
			echo ".dylib"
		;;
	esac
}

function return_optimal_compiler {
	case $(return_enduser_os) in
		"GNU/Linux" | "Non-GNU/Linux")
			echo "gcc"
		;;
		"Darwin" | "A BSD")
			echo "clang"
		;;
	esac
}

function return_version {
	echo "0.1.0"
}

function main {
	$1
}

main $1