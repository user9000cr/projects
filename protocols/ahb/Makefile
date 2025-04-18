# Top-level Makefile in protocols/ahb

# Tool & paths
VERILATOR = verilator
SRC_DIR = rtl
TB_DIR = tb
BUILD_DIR = obj_dir
TOP_MODULE = tb_ahb_top
VCD_FILE = dump.vcd

# Source files
RTL_SRCS = $(SRC_DIR)/ahb_slave.sv $(SRC_DIR)/ahb_master.sv
TB_SRCS = $(TB_DIR)/$(TOP_MODULE).sv

# Default target: build & run
all: build run


build:
	$(VERILATOR) --Wall --cc --exe --trace \
	  --timing -Wno-UNUSED \
		$(RTL_SRCS) $(TB_SRCS) \
		-CFLAGS "-std=c++11" \
		--top-module $(TOP_MODULE) \
		--Mdir obj_dir \
		-o $(TOP_MODULE)_sim

run:
	./$(TOP_MODULE)_sim
	@echo "Simulation complete. VCD dumped to $(VCD_FILE)"

gtkwave:
	gtkwave $(VCD_FILE) &

clean:

