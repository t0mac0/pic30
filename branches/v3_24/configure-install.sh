#!/bin/bash

set -a

source $(dirname $0 )/env.sh

if ! system=$(2>/dev/null uname -s) || [ -z "${system}" ]
then
    system="local"
fi

CGLAGS="-DMCHP_VERSION=v${MCHP_VERSION}-${system}"


if cd ${BINUTILS_DIR}
then
    if ./configure --prefix=${C30_INSTALL} --target=pic30-coff
    then

	find ${BINUTILS_DIR} -path '*/.svn' -prune -o -name "*.y" -o -name "*.l" -exec touch '{}' ';'

	if make
	then
	    if sudo make install
	    then

		if cd ${GCC_DIR}/build
		then
		    if ${GCC_DIR}/gcc-${GCC_VERSION}/configure --prefix=${C30_INSTALL} --target=pic30-coff --enable-languages=c
		    then

			find ${GCC_DIR} -path '*/.svn' -prune -o -name "*.y" -o -name "*.l" -exec touch '{}' ';'

			if make
			then
			    if ! sudo make install
			    then
				echo "$0 Error running 'make install'." >&2
				exit 1
			    else
				if ! sudo $(dirname $0 )/instalink.sh
				then
				    echo "$0 Error symlinking in ${C30_INSTALL}." >&2
				    exit 1
				fi
			    fi
			else
			    echo "$0 Error running make in ${GCC_DIR}/build" >&2
			    exit 1
			fi
		    else
			echo "$0 Error running configure in ${GCC_DIR}/build" >&2
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
	echo "$0 Error running configure in ${BINUTILS_DIR}/acme" >&2
	exit 1
    fi
else
    echo "$0 Error directory not found BINUTILS_DIR=${BINUTILS_DIR}." >&2
    exit 1
fi
