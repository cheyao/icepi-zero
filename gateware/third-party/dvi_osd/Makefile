VERILOG_SOURCES := $(wildcard *.v) $(wildcard *.sv)
TEST_SOURCES := $(wildcard tb/*.v) $(wildcard tb/*.sv)
OUTPUT := bitstream
PACKAGE := CABGA256
TOP_MODULE = top_spi_char
TOP_MODULE_FILE = top/$(TOP_MODULE).v

VERILOG_FILES = \
$(TOP_MODULE_FILE) \
hdl/spi_osd_v.v \
hdl/spi_ram_btn_v.v \
hdl/osd.v \
hdl/ecp5pll.sv \
hdl/spirw_slave_v.v \
hdl/bram_true2p_2clk.v \
hdl/vga.v \
hdl/vga2dvid.v \
hdl/tmds_encoder.v \

all: debug osd.mem

osd.mem: osd.txt
	hexdump -n 1536 -v -e '1/1 "%02x " "\n"' $< > $@

%.json: $(VERILOG_FILES)
	rm -f $(OUTPUT).bit $(OUTPUT).config $(OUTPUT).json
	yosys -p 'synth_ecp5 -abc9 -top $(TOP_MODULE) -json $@' $^

%.config: %.json icepi-zero.lpf
	nextpnr-ecp5 --25k --router router2 --package $(PACKAGE) --lpf icepi-zero.lpf --json $< --textcfg $@ # 2> log.txt
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
