#!/bin/bash

set -a

source $(dirname $0 )/env.sh

CFLAGS="-DMCHP_VERSION=v${MCHP_VERSION}-${SYSTEM_NAME}"


if cd ${BINUTILS_DIR}
then

    find ${BINUTILS_DIR} -path '*/.svn' -prune -o -name "*.y" -o -name "*.l" -exec touch '{}' ';'

    if make
    then
	if sudo make install
	then

	    if cd ${GCC_DIR}/build
	    then

		find ${GCC_DIR} -path '*/.svn' -prune -o -name "*.y" -o -name "*.l" -exec touch '{}' ';'

		if make
		then
		    if ! sudo make install
		    then
			echo "$0 Error running 'make install'." >&2
			exit 1
		    else
			if ! sudo ${TOPD}/instalink.sh
			then
			    echo "$0 Error symlinking in ${C30_INSTALL}." >&2
			    exit 1
			else
			    echo >&2
			    echo "$0 Completed rebuild and install." >&2
			    exit 0
			fi
		    fi
		else
		    echo "$0 Error running make in ${GCC_DIR}/build" >&2
		    exit 1
		fi
	    else
		echo "$0 Error directory not found GCC_DIR/build=${GCC_DIR}/build." >&2
		exit 1
	    fi
	else
	    echo "$0 Error running make install in ${BINUTILS_DIR}/acme" >&2
	    exit 1
	fi
    else
	echo "$0 Error running make in ${BINUTILS_DIR}/acme" >&2
	exit 1
    fi
else
    echo "$0 Error directory not found BINUTILS_DIR=${BINUTILS_DIR}." >&2
    exit 1
fi
