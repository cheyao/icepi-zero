VERILOG_SOURCES := $(wildcard *.v) $(wildcard *.sv) \
		   ../external/usb_hid_host.v \
		   ../external/usb_hid_host_rom.v
OUTPUT := bitstream
PACKAGE := CABGA256

all: debug

clean:
	rm -f $(OUTPUT).bit $(OUTPUT).config $(OUTPUT).json

%.json: $(VERILOG_SOURCES)
	yosys -p 'synth_ecp5 -top top -json $@' $^

%.config: %.json icepi-zero.lpf
	nextpnr-ecp5 --25k --package $(PACKAGE) --lpf icepi-zero.lpf --json $< --textcfg $@

%.bit: %.config
	ecppack $< $@

build: clean $(OUTPUT).bit

debug: build
	openFPGALoader -cft231X --pins=7:3:5:6 $(OUTPUT).bit

install: build
	openFPGALoader -cft231X --pins=7:3:5:6 $(OUTPUT).bit --write-flash

install-bitstream: 
	openFPGALoader -cft231X --pins=7:3:5:6 $(OUTPUT).bit --write-flash

lint:
	verilator --lint-only -Wall -Wno-DECLFILENAME -Wno-WIDTHEXPAND $(VERILOG_SOURCES)

help: 
	echo "Usage: make [option]"
	echo "Options:"
	echo "- install: install to flash"
	echo "- debug: install to chip's temp memory (bitstream lost on power loss)"
	echo "- build: builds the bitstream"
	echo "- clean: delete all temparary files"

.PHONY: build clean install

# Board revision targets (v1.0 ... v1.4 / latest)
-include ../../board.mk
