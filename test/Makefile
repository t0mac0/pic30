#
TARGET_HEX=test.hex

PART=30f4013

PARTFAMILY=dsPIC30F


#
# We're explicitly defining all paths for the compiler because its
# internal path code (use of gcc::libcpp) is broken.
#
CC=pic30-gcc
AS=pic30-as
LD=pic30-ld
BX=pic30-bin2hex

PIC30=/usr/local/pic30

SRCS=$(wildcard *.c)

HEADERS=$(wildcard *.h)

INCLUDEPATH=-I$(PIC30)/support/$(PARTFAMILY)/h -I$(PIC30)/include

LIBS=	-lpic30 \
	-lp$(subst f,F,$(PART))

LIBPATH=-L$(PIC30)/lib \
	-L$(PIC30)/lib/$(PARTFAMILY)

LINKERSCRIPT=$(PIC30)/support/$(PARTFAMILY)/gld/p$(PART).gld

TARGET_COFF=$(patsubst %.hex, %.coff, $(TARGET_HEX))
OBJS=$(patsubst %.c, %.o, $(SRCS))


$(TARGET_HEX): $(TARGET_COFF)
	$(BX) $(TARGET_COFF)

$(TARGET_COFF): $(OBJS)
	$(LD) $(LIBPATH) $(LIBS) -T$(LINKERSCRIPT) -o $@ $^

%.o:	%.c $(HEADERS)
	$(CC) $(INCLUDEPATH) -c -mcpu=$(PART) $(CFLAGS) -o $@ $<

clean:
	$(RM) *.o *.coff *~
