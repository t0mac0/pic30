#!/bin/bash

source $(dirname $0 )/env.sh

function fpatch {

    if dt=$(diff ${src} ${tgt})
    then
	return 0

    elif [ -n "${dt}" ]
    then
	patchfile="$(echo ${src} | sed "s%${rere}%/patches/${rere}%").diff"
	patchdir=$(dirname ${patchfile})
	if [ ! -d ${patchdir} ]
	then
	    mkdir -p ${patchdir}
	fi
	diff ${src} ${tgt} > ${patchfile}
	ls -l ${patchfile}
	return 0
    else
	echo "$0 Error in 'diff ${src} ${tgt}'." >&2
	return 1
    fi
}
function fdriver {
    for src in $(find ${root} -path '*/.svn' -prune -o -type f -print )
    do
	if tgt=$(echo ${src} | sed "s%${rere}%/${pres}${rere}%")
	then
	    if fpatch
	    then
		continue
	    else
		echo "$0 Error in 'fpatch ${src} ${tgt}'." >&2
		return 1
	    fi
	else
	    echo "$0 Error in 'echo ${src} | sed \"s%${rere}%/${pres}${rere}%\"'." >&2
	    return 1
	fi
    done
    return 0
}

root=${GCC_DIR}
rere="/gcc-"
pres="gcc"
if fdriver
then
    root=${BINUTILS_DIR}
    rere="/acme/"
    pres="binutils"
    if fdriver
    then
	root=${C30_RESOURCE}
	rere="/c30_resource/"
	pres="binutils"
	if fdriver
	then
	    exit 0
	else
	    echo "$0 Error in fdriver '${C30_RESOURCE}'." >&2
	    exit 1
	fi
    else
	echo "$0 Error in fdriver '${BINUTILS_DIR}'." >&2
	exit 1
    fi
else
    echo "$0 Error in fdriver '${GCC_DIR}'." >&2
    exit 1
fi
