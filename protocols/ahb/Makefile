# Top-level Makefile in protocols/ahb

# Tool & paths
IVERILOG = iverilog
VVP = vvp
SRC_DIR = rtl
TB_DIR = tb
BUILD_DIR = build
TOP_MODULE = tb_ahb_top
VCD_FILE = dump.vcd
OUT_FILE = $(BUILD_DIR)/$(TOP_MODULE).vvp

# Source files
RTL_SRCS = $(SRC_DIR)/ahb_slave.sv $(SRC_DIR)/ahb_master.sv
TB_SRCS = $(TB_DIR)/$(TOP_MODULE).sv
SRCS = $(RTL_SRCS) $(TB_SRCS)

# Default target
all: $(OUT_FILE) run

$(OUT_FILE): $(SRCS)
	@mkdir -p $(BUILD_DIR)
	$(IVERILOG) -g2012 -o $@ $(SRCS)

run:
	$(VVP) $(OUT_FILE)
	@echo "Simulation complete. VCD dumped to $(VCD_FILE)"

gtkwave:
	gtkwave $(VCD_FILE) &

clean:
	rm -rf $(BUILD_DIR) $(VCD_FILE)
