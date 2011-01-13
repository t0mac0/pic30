
C30_INSTALL=/usr/local/pic30

GCC_VERSION=4.0.3
MCHP_VERSION=3.24

TOPD=$(cd $(dirname $0); pwd)

MPLAB_C30_WIN32=${TOPD}/mplabc30-win32_v3_24

BINUTILS_DIR=${TOPD}/acme
GCC_DIR=${TOPD}/gcc-${GCC_VERSION}
C30_RESOURCE=${TOPD}/c30_resource

if ! SYSTEM_NAME=$(2>/dev/null uname -s) || [ -z "${SYSTEM_NAME}" ]
then
    SYSTEM_NAME="local"
fi
