#!/bin/bash

source $(dirname $0 )/env.sh

if [ -n "${C30_INSTALL}" ]&&
    [ -d "${C30_INSTALL}" ]&&
    cd ${C30_INSTALL}/bin
then
    for fil in $(ls pic30-coff-* | egrep -v pic30-coff-pic30-coff)
    do
	lfil=$(echo $fil | sed 's/-coff-/-/g')
	2>/dev/null sudo ln -s ${fil} ${lfil}
    done
    fil=$(2>/dev/null ls pic30-coff-gcc-* )
    if [ -n "${fil}" ]&&[ -f "${fil}" ]
    then
	lfil=pic30-gcc
	if [ ! -e ${lfil} ]
	then
	    if ! sudo ln -s "${fil}" ${lfil} 
	    then
		echo "$0 Error in 'ln -s \"${fil}\" ${lfil}'." >&2
		exit 1
	    fi
	fi
	exit 0
    else
	echo "$0 Error file not found '${fil}' in '${C30_INSTALL}/bin'." >&2
	exit 1
    fi
else
    echo "$0 Error directory not found C30_INSTALL=${C30_INSTALL}." >&2
    exit 1
fi
