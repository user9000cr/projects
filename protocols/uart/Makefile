
TOP_MODULE=uart
SIMULATOR=verilator

all:
	$(SIMULATOR) --sv --cc rtl/$(TOP_MODULE).sv --exe sim_main.cpp --trace
	make -j -C obj_dir -f V$(TOP_MODULE).mk V$(TOP_MODULE)
	./obj_dir/V$(TOP_MODULE)
