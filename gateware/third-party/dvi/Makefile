TOP_MODULE = top_vgatest
TOP_MODULE_FILE = top/$(TOP_MODULE).v

VERILOG_FILES = \
  $(TOP_MODULE_FILE) \
  hdl/ecp5pll.sv \
  hdl/vga.v \
  hdl/vga2dvid.v \
  hdl/tmds_encoder.v

OUTPUT := bitstream
PACKAGE := CABGA256

all: debug

%.json: $(VERILOG_FILES)
	rm -f $(OUTPUT).bit $(OUTPUT).config $(OUTPUT).json
	yosys -p 'synth_ecp5 -top $(TOP_MODULE) -json $@' $^

%.config: %.json icepi-zero.lpf
	nextpnr-ecp5 --timing-allow-fail --25k --package $(PACKAGE) --lpf icepi-zero.lpf --json $< --textcfg $@ # 2> log.txt
	# cat log.txt | grep Device -A 28

%.bit: %.config
	ecppack $< $@

build: $(OUTPUT).bit

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

clean:
	rm -f $(OUTPUT).bit $(OUTPUT).config $(OUTPUT).json

.PHONY: build clean install

# Board revision targets (v1.0 ... v1.4 / latest)
-include ../../board.mk
