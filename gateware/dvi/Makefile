SOURCE_FILES := hdl/vga.sv \
			    dvi_out.sv \

VERILOG_FILES := ${SOURCE_FILES} \
			     hdl/vga2tmds.sv \
				 hdl/tmds_encoder.sv \
				 hdl/pll.v \
				 top/top.sv \

SIMULATION_FILES := ${SOURCE_FILES} \

OUTPUT := bitstream
PACKAGE := CABGA256

ifneq ($(words $(CURDIR)),1)
  $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
endif

ifeq ($(VERILATOR_ROOT),)
  VERILATOR = verilator
else
  export VERILATOR_ROOT
  VERILATOR = $(VERILATOR_ROOT)/bin/verilator
endif

all: debug

%.json: ${VERILOG_FILES}
	rm -f ${OUTPUT}.bit ${OUTPUT}.config ${OUTPUT}.json
	yosys -p 'synth_ecp5 -top top -json $@' $^

%.config: %.json icepi-zero.lpf
	nextpnr-ecp5 --25k --package ${PACKAGE} --lpf icepi-zero.lpf --json $< --textcfg $@ # 2> log.txt
	# cat log.txt | grep Device -A 28

%.bit: %.config
	ecppack --compress $< $@

build: ${OUTPUT}.bit

debug: build
	openFPGALoader -b icepi-zero ${OUTPUT}.bit

install: build
	openFPGALoader -b icepi-zero ${OUTPUT}.bit --write-flash

install-bitstream:
	openFPGALoader -b icepi-zero ${OUTPUT}.bit --write-flash

lint: ${SIMULATION_FILES}
	${VERILATOR} --lint-only -Wall -Wno-DECLFILENAME -Wno-WIDTHEXPAND ${SIMULATION_FILES}

sim: ${SIMULATION_FILES}
	${VERILATOR} -cc --exe --build -Wall -Wno-DECLFILENAME -LDFLAGS "-lboost_program_options -lSDL3" \
	             -Wno-WIDTHEXPAND -Wno-fatal -O2 --trace-vcd --threads 8 -CFLAGS "-std=c++23" \
				 -j ${SIMULATION_FILES} sim/main.cpp verilated_vcd_c.cpp

help:
	echo "Usage: make [option]"
	echo "Options:"
	echo "- install: install to flash"
	echo "- debug: install to chip's temp memory (bitstream lost on power loss)"
	echo "- build: builds the bitstream"
	echo "- clean: delete all temparary files"

clean:
	rm -f $(OUTPUT).bit $(OUTPUT).config $(OUTPUT).json

.PHONY: build clean install sim lint help

# Board revision targets (v1.0 ... v1.4 / latest)
-include ../board.mk
