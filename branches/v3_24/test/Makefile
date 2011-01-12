#
# Makefile for C30 based projects
# Version 0.1
# (C) 2010 Matt Jervis <dev@electricrock.co.nz>
# http://www.electricrock.co.nz/blog
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

TARGET=test.hex

PART=30f4013

PARTFAMILY=dsPIC30F
#PARTFAMILY=dsPIC33F
#PARTFAMILY=pic24H
#PARTFAMILY=pic24L

GCC=pic30-gcc
AS=pic30-as
LD=pic30-ld

C30PATH=/usr/local/pic30

SRCS=$(wildcard *.c) \
#	$(wildcard src/*.c) \
#	$(wildcard src/dir1/*.c)

INCLUDEPATH=.\
#	./include 

# If you want to on-chip debug then you probably want -O0 (I think)
CFLAGS=-g -O2

# Comment out the second lib here if you don't need the periphal libraries
LIBS=	-lpic30 \
	-lp$(subst f,F,$(PART))

# ----------------------------------------------------------------------------
#
LIBPATH=-L$(C30PATH)/lib \
	-L$(C30PATH)/lib/$(PARTFAMILY)

LINKERSCRIPT=$(C30PATH)/support/$(PARTFAMILY)/gld/p$(PART).gld


OBJS=$(patsubst %.c, %.o, $(SRCS))
LSTS=$(patsubst %.c, %.lst, $(SRCS))
ASMS=$(patsubst %.c, %.s, $(SRCS))

HEADERS=$(wildcard *.h)


.PHONY: target
target: $(TARGET)

.PHONY: assembly
assembly: $(ASMS)

.PHONY: objects
objects: $(OBJS)

.PHONY: all
all: target assembly objects


.PHONY: clean
clean:
	-rm $(OBJS)
	-rm $(TARGET)
	-rm $(LSTS)
	-rm $(ASMS)

%.s:	%.c $(HEADERS)
	$(GCC) -S -mcpu=$(PART) $(CFLAGS) -o $@ $<

%.o:	%.c $(HEADERS)
	$(GCC) -c -mcpu=$(PART) $(CFLAGS) -o $@ $<

$(TARGET): $(OBJS)
	$(LD) $(LIBPATH) $(LIBS) -T$(LINKERSCRIPT) -o $@ $^
