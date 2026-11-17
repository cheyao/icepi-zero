VERILOG_SOURCES := $(wildcard *.v) $(wildcard *.sv)
TEST_SOURCES := $(wildcard tb/*.v) $(wildcard tb/*.sv)
OUTPUT := bitstream
PACKAGE := CABGA256
FPGA_SIZE ?= 25k

all: debug run

%.json: $(VERILOG_SOURCES)
	rm -f $(OUTPUT).bit $(OUTPUT).config $(OUTPUT).json
	yosys -p 'synth_ecp5 -top top -json $@' $^

%.config: %.json icepi-zero.lpf
	nextpnr-ecp5 --$(FPGA_SIZE) --package $(PACKAGE) --lpf icepi-zero.lpf --json $< --textcfg $@ # 2> log.txt
	# cat log.txt | grep Device -A 28

%.bit: %.config
	ecppack --compress $< $@

build: $(OUTPUT).bit

debug: build
	openFPGALoader -b icepi-zero $(OUTPUT).bit
	
run:
	openocd -f icepi-zero.cfg -f jtagtest.tcl
	@echo "(type \"make run\" to repeat the JTAG test)"

install: build
	openFPGALoader -b icepi-zero $(OUTPUT).bit --write-flash

install-bitstream:
	openFPGALoader -b icepi-zero $(OUTPUT).bit --write-flash

lint:
	verilator --lint-only -Wall -Wno-DECLFILENAME -Wno-WIDTHEXPAND $(VERILOG_SOURCES)

help:
	@echo "Usage: make [option]"
	@echo "Options:"
	@echo "- install: install to flash"
	@echo "- debug: install to chip's temp memory (bitstream lost on power loss)"
	@echo "- build: builds the bitstream"
	@echo "- clean: delete all temparary files"
	@echo "- run: execute a tcl script to communicate with the running design"

clean:
	rm -f $(OUTPUT).bit $(OUTPUT).config $(OUTPUT).json

.PHONY: build clean install

# Board revision targets (v1.0 ... v1.4 / latest)
-include ../../board.mk
