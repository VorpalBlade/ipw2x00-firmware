DESTDIR ?=
FIRMWAREDIR = /usr/lib/firmware
LICENSEDIR = /usr/share/licenses/ipw2x00-firmware

FIRMWARES = \
	ipw2100-1.3.fw \
	ipw2100-1.3-i.fw \
	ipw2100-1.3-p.fw \
	ipw2200-bss.fw \
	ipw2200-ibss.fw \
	ipw2200-sniffer.fw

COMPRESSED_FIRMWARES = $(patsubst %.fw,%.fw.xz,$(FIRMWARES))

all: $(COMPRESSED_FIRMWARES)

clean:
	rm -f *.xz

install: $(COMPRESSED_FIRMWARES)
	install -d $(DESTDIR)/$(FIRMWAREDIR) $(DESTDIR)/$(LICENSEDIR)
	install -m 644 -t $(DESTDIR)/$(FIRMWAREDIR) $(COMPRESSED_FIRMWARES) 
	install -m 644 -t $(DESTDIR)/$(LICENSEDIR) LICENSE

# This is the specific compression flags needed for the kernel to accept it.
%.fw.xz: %.fw
	xz -C crc32 -c $^ > $@

.PHONY: all clean install
