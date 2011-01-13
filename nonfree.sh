#!/bin/bash

source $(dirname $0)/env.sh

function chmdirs {
    while true
    do
	if dlist=$(find ${MPLAB_C30_WIN32} -type d ! -executable )
	then
	    if [ -n "${dlist}" ]
	    then
		chmod 755 ${dlist}
	    else
		return 0
	    fi
	else
	    return 1
	fi
    done
}
function chmfils {
    if flist=$(find ${MPLAB_C30_WIN32} -type f ) && [ -n "${flist}" ]
    then
	if chmod 644 ${flist}
	then
	    return 0
	else
	    return 1
	fi
    else
	return 1
    fi
}

if [ -d ${MPLAB_C30_WIN32} ]
then
    if [ -e ${MPLAB_C30_WIN32}/examples ]
    then
	rm -rf ${MPLAB_C30_WIN32}/examples
    fi
    if [ -e ${MPLAB_C30_WIN32}/docs ]
    then
	rm -rf ${MPLAB_C30_WIN32}/docs
    fi
    if chmdirs
    then
	if chmfils
	then

	    if sudo mkdir -p ${C30_INSTALL}
	    then

		if sudo cp -r ${MPLAB_C30_WIN32}/support ${C30_INSTALL}
		then
		    if sudo cp -r ${MPLAB_C30_WIN32}/include ${C30_INSTALL}
		    then
			if sudo cp -r ${MPLAB_C30_WIN32}/lib ${C30_INSTALL}
			then
			    if sudo cp -p ${MPLAB_C30_WIN32}/bin/c30_device.info ${C30_INSTALL}/lib
			    then

				if sudo ln -s ${C30_INSTALL}/lib/c30_device.info ${C30_INSTALL}/bin
				then
				    if sudo ln -s ${C30_INSTALL}/lib/c30_device.info ${C30_INSTALL}/lib/gcc
				    then
					if sudo ln -s ${C30_INSTALL}/lib/c30_device.info ${C30_INSTALL}/libexec/gcc/pic30-coff/4.0.2
					then
					    exit 0
					else
					    echo "$0 Error in 'ln -s ${C30_INSTALL}/lib/c30_device.info ${C30_INSTALL}/libexec/gcc/pic30-coff/4.0.2'."
					    exit 1
					fi
				    else
					echo "$0 Error in 'ln -s ${C30_INSTALL}/lib/c30_device.info ${C30_INSTALL}/lib/gcc'."
					exit 1
				    fi
				else
				    echo "$0 Error in 'ln -s ${C30_INSTALL}/lib/c30_device.info ${C30_INSTALL}/bin'."
				    exit 1
				fi
			    else
				echo "$0 Error in 'cp -p ${MPLAB_C30_WIN32}/bin/c30_device.info ${C30_INSTALL}/lib'."
				exit 1
			    fi
			else
			    echo "$0 Error in 'cp -r ${MPLAB_C30_WIN32}/lib ${C30_INSTALL}'."
			    exit 1
			fi
		    else
			echo "$0 Error in 'cp -r ${MPLAB_C30_WIN32}/include ${C30_INSTALL}'."
			exit 1
		    fi
		else
		    echo "$0 Error in 'cp -r ${MPLAB_C30_WIN32}/support ${C30_INSTALL}'."
		    exit 1
		fi
	    else
		echo "$0 Error unable to create directory ${C30_INSTALL}."
		exit 1
	    fi
	else
	    echo "$0 Error missing files under MPLAB_C30_WIN32=${MPLAB_C30_WIN32}."
	    exit 1
	fi
    else
	echo "$0 Error missing directories under MPLAB_C30_WIN32=${MPLAB_C30_WIN32}."
	exit 1
    fi
else
    echo "$0 Error directory not found MPLAB_C30_WIN32=${MPLAB_C30_WIN32}"
    exit 1
fi
