
# paths
PREFIX = /
MANPREFIX = $(PREFIX)/share/man
ETCPREFIX = /etc
INITPREFIX = /etc/init.d

#CC = cc
CPPFLAGS =
CFLAGS   = -Wextra -Wall -Os
LDFLAGS  = -s -static

ARCH=armhf
CROSS_COMPILE=arm-linux-gnueabihf-
PREFIX=/bin

gslx680: driver.o
	gcc -o gslx680 driver.o -lm

driver.o: driver.c driver.h
	gcc -c -o driver.o driver.c

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install gslx680 $(DESTDIR)$(PREFIX)/
	mkdir -p $(DESTDIR)$(INITPREFIX)
	install igslx680.init /$(DESTDIR)$(INITPREFIX)/igslx680
	install gslx68x.cfg /$(DESTDIR)$(INITPREFIX)/gslx68x.cfg
	#install gslx680.service /etc/systemd/system/gslx680.service
	rm -f /etc/init.d/gslx680
	#update-rc.d igslx680 defaults

clean:
	rm -rf gslx680 *.o

