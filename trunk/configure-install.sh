#!/bin/bash

source $(dirname $0 )/env.sh

function instalink {
    if cd ${C30_INSTALL}
    then
	for fil in $(ls pic30-coff-* | egrep -v pic30-coff-pic30-coff)
	do
	    lfil=$(echo $fil | sed 's/-coff-/-/g')
	    2>/dev/null ln -s ${fil} ${lfil}
	done
	return 0
    else
	echo "$0 Error directory not found C30_INSTALL=${C30_INSTALL}." >&2
	return 1
    fi
}

if cd ${BINUTILS_DIR}/acme
then
    if ./configure --prefix=${C30_INSTALL} --target=pic30-coff
    then

	find . -name "*.y" -o -name "*.l" -exec touch '{}' ';'

	if make
	then
	    if sudo make install
	    then

		if cd ${GCC_DIR}/build
		then
		    if ${GCC_DIR}/gcc-${GCC_VERSION}/configure --prefix=${C30_INSTALL} --target=pic30-coff --enable-languages=c
		    then

			find . -name "*.y" -o -name "*.l" -exec touch '{}' ';'

			if make
			then
			    if ! sudo make install
			    then
				echo "$0 Error running 'make install'." >&2
				exit 1
			    else
				if ! sudo instalink
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
