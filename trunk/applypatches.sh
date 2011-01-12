#!/bin/bash

source $(dirname $0 )/env.sh

for patchfile in $(find ${TOPD}/patches -type f -name '*.diff' )
do
    srcf=$(echo ${patchfile} | sed 's%/patches/%/%; s%\.diff$%%')
    if patch $* ${srcf} ${patchfile}
    then
	ls -l ${srcf} 
    else
	echo "$0 Error in 'patch ${srcf} ${patchfile}'." >&2
	exit 1
    fi
done
exit 0
