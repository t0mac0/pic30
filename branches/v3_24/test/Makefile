
TARGET_HEX=test.hex

PART=30f4013

PARTFAMILY=dsPIC30F

CC=pic30-gcc
AS=pic30-as
LD=pic30-ld
BX=pic30-bin2hex

PIC30=/usr/local/pic30

SRCS=$(wildcard *.c)

HEADERS=$(wildcard *.h)

INCLUDEPATH=-I$(PIC30)/support/$(PARTFAMILY)/h -I$(PIC30)/include

#CFLAGS=-g -O2

LIBS=	-lpic30 \
	-lp$(subst f,F,$(PART))

LIBPATH=-L$(PIC30)/lib \
	-L$(PIC30)/lib/$(PARTFAMILY)

LINKERSCRIPT=$(PIC30)/support/$(PARTFAMILY)/gld/p$(PART).gld

TARGET_COFF=$(patsubst %.hex, %.coff, $(TARGET_HEX))
OBJS=$(patsubst %.c, %.o, $(SRCS))
LSTS=$(patsubst %.c, %.lst, $(SRCS))
ASMS=$(patsubst %.c, %.s, $(SRCS))


$(TARGET_HEX): $(TARGET_COFF)
	$(BX) $(TARGET_COFF)

$(TARGET_COFF): $(OBJS)
	$(LD) $(LIBPATH) $(LIBS) -T$(LINKERSCRIPT) -o $@ $^

%.s:	%.c $(HEADERS)
	$(CC) $(INCLUDEPATH) -S -mcpu=$(PART) $(CFLAGS) -o $@ $<

%.o:	%.c $(HEADERS)
	$(CC) $(INCLUDEPATH) -c -mcpu=$(PART) $(CFLAGS) -o $@ $<

.PHONY: clean
clean:
	-rm $(OBJS)
	-rm $(TARGET)
	-rm $(LSTS)
	-rm $(ASMS)
