#!/bin/bash

source $(dirname $0)/env.sh

function fconvertext {
    dir="${1}"
    if find ${dir} -path '*/.svn' -prune -o -type f -exec fromdos '{}' ';'
    then
	echo "$0 ${dir}" >&2
	return 0
    else
	echo "$0 Error in \"find ${dir} -path '*/.svn' -prune -o -type f -exec fromdos '{}' ';'\"."  >&2
	echo "$0 Ensure package 'tofrodos' is installed."  >&2
	return 1
    fi
}

if [ -n "${1}" ]
then
    for arg in $*
    do
	if [ -d "${arg}" ]
	then
	    if fconvertext ${arg}
	    then
		continue
	    else
		exit 1
	    fi
	elif [ -f "${arg}" ]
	then
	    continue
	else
	    cat<<EOF >&2
Usage
    $0 [directories]

Description

    Apply CRLF-to-LF text file conversion on all files found in
    directories.

    Argument directories ignore any intermixed files.

    Default directories are
	${GCC_DIR} 
	${BINUTILS_DIR} 
	${C30_RESOURCE}

EOF
	    exit 1
	fi
    done
else

    for dir in ${GCC_DIR} ${BINUTILS_DIR} ${C30_RESOURCE}
    do
	if fconvertext ${dir}
	then
	    continue
	else
	    exit 1
	fi
    done
fi
