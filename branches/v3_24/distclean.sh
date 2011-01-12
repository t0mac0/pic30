#!/bin/bash

for tgt in $(find $(pwd) -type f -name configure | sed 's#/configure##' )
do
 cd $tgt
 make distclean
done
