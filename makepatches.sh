#!/bin/bash

source $(dirname $0 )/env.sh

patchesdn=patches

function fpatch {

    if [ -f ${src} ]&&[ -f ${tgt} ]
    then
	if dt=$(diff ${src} ${tgt})
	then
	    return 0

	elif [ -n "${dt}" ]
	then
	    patchfile="$(echo ${src} | sed "s%/${srcdn}/%/${patchesdn}/${srcdn}/%").diff"
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
    else
	echo "$0 Error missing file '${tgt}'." >&2
	return 1
    fi
}
function fdriver {
    for src in $(find ${root}/${srcdn} -path '*/.svn' -prune -o -type f -print )
    do
	if tgt=$(echo ${src} | sed "s%/${srcdn}/%/${tgtdn}/%")
	then
	    if fpatch
	    then
		continue
	    else
		echo "$0 Error in 'fpatch ${src} ${tgt}'." >&2
		return 1
	    fi
	else
	    echo "$0 Error in 'echo ${src} | sed \"s%/${srcdn}/%/${tgtdn}/%\"'." >&2
	    return 1
	fi
    done
    return 0
}

root=${TOPD}
srcdn="gcc-${GCC_VERSION}"
tgtdn="gcc/${srcdn}"
if fdriver
then
    srcdn="acme"
    tgtdn="binutils"
    if fdriver
    then
	srcdn="c30_resource"
	tgtdn="binutils"
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
