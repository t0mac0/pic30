# About #

Branches of [Microchip](http://www.microchip.com/) versions of GPL code for GCC and Binutils, patched from sources listed below.

# Status #

This works, however only far fewer patches are necessary.  Many of the applied patches should be backed out.

# How to build #

  1. Install prerequisites (on Linux Debian/Ubuntu with)
```
     sudo apt-get install subversion build-essential bison flex tofrodos
```
  1. Checkout a branch of GPL code
```
     svn co http://pic30.googlecode.com/svn/branches/v3_24 pic30_324
```
  1. Edit `env.sh` to point to a **local copy** of your (windows) `MPLAB C30` directory
```
     cd pic30_324
     {editor} env.sh
```
  1. Configure-install GPL code (will ask for password to install)
```
     ./configure-install.sh
```
  1. Run `nonfree.sh` to integrate a **copy** of the (windows) `MPLAB C30` directory
```
     ./nonfree.sh
```
> > The nonfree script **is destructive** and **requires** it's own local copy of the `MPLAB C30` directory.


> This local copy can be made using tar, for example
```
     wd=$(pwd)
     cd "/C/Program Files/Microchip/MPLAB C30"
     tar cf /tmp/mplabc30-win32_v3_24.tar * 
     cd ${wd}

     mkdir mplabc30-win32_v3_24
     cd mplabc30-win32_v3_24
     tar xfp /tmp/mplabc30-win32_v3_24.tar

     ../nonfree.sh
```
  1. Add to your PATH
```
     /usr/local/pic30/bin
```
  1. Have a look at
```
     test/Makefile
```

# Objective #

The objective is to be able to match sources to binaries reliably, and ideally to fix bugs.

# See also #

  * [Microchip MPLAB X (Linux!)](http://ww1.microchip.com/downloads/mplab/X_Beta/)

  * [Microchop c30](http://www.electricrock.co.nz/blog/microchip-c30/)

  * [Piklab: Compilation of pic30 version 3.01](http://sourceforge.net/apps/mediawiki/piklab/index.php?title=Compilation_of_pic30_version_3.01)

  * [Debian templates for dsPIC build toolchain](http://old.nabble.com/Debian-templates-for-dsPIC-build-toolchain-2.05-td7886279.html)

  * [Microchip MPLAB C30 v3.00](http://staff.ee.sun.ac.za/pjrandewijk/wiki/index.php/Microchip_MPLAB_C30_v3.00)

  * [Compiling mplab c30 v311b under linux](http://embeddedfreak.wordpress.com/2008/10/10/compiling-mplab-c30-v311b-under-linux/)
