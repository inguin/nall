# vim:ts=4:sw=4:noexpandtab:autoindent
PRGNAME=nall
VERSION=0.6
PREFIX=/usr/local
SRC=$(PRGNAME).c na.c menu.c about.c cb.c
CFLAGS=`pkg-config --cflags glib-2.0` `pkg-config --cflags gtk+-2.0`
LDFLAGS=`pkg-config --libs glib-2.0` `pkg-config --libs gtk+-2.0`

all: $(SRC) *.h
	sed -e "s#__VERSION__#$(VERSION)#" version.h.in > version.h
	sed -e "s#__VERSION__#$(VERSION)#" PKGBUILD.in > PKGBUILD
	sed -e "s#__PREFIX__#$(PREFIX)#" $(PRGNAME).desktop.in > $(PRGNAME).desktop
	$(CC) -Wall -Wextra $(SRC) -o $(PRGNAME) $(CFLAGS) $(LDFLAGS)

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(PREFIX)/share/applications
	mkdir -p $(DESTDIR)$(PREFIX)/share/icons
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/nall/examples

	install $(PRGNAME) $(DESTDIR)$(PREFIX)/bin/
	install $(PRGNAME).desktop $(DESTDIR)$(PREFIX)/share/applications/
	install $(PRGNAME).png $(DESTDIR)$(PREFIX)/share/icons/
	install scripts/* $(DESTDIR)$(PREFIX)/share/doc/nall/examples

uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/$(PRGNAME) 
	$(RM) $(DESTDIR)$(PREFIX)/share/icons/$(PRGNAME).png 
	$(RM) $(DESTDIR)$(PREFIX)/share/applications/$(PRGNAME).desktop
	$(RM) -r $(DESTDIR)$(PREFIX)/share/doc/nall
dist:
	cd ..; cp -a $(PRGNAME) $(PRGNAME)-$(VERSION); $(RM) -r $(PRGNAME)-$(VERSION)/.git; tar cvf $(PRGNAME)-$(VERSION).tar $(PRGNAME)-$(VERSION); $(RM) -r $(PRGNAME)-$(VERSION); cd -
clean:
	$(RM) $(PRGNAME) $(PRGNAME).desktop version.h PKGBUILD *~
