#!/bin/bash

source $(dirname $0 )/env.sh

if cd ${BINUTILS_DIR}
then
    if make distclean
    then
	if cd ${GCC_DIR}/build 
	then
	    2>/dev/null rm -rf * 
	    exit 0
	else
	    echo "$0 Error directory not found GCC_DIR/build='${GCC_DIR}/build'." >&2
	    exit 1
	fi
    else
	echo "$0 Error in 'make distclean' in directory '${BINUTILS_DIR}." >&2
	exit 1
    fi
else
    echo "$0 Error directory not found BINUTILS_DIR='${BINUTILS_DIR}'." >&2
    exit 1
fi
