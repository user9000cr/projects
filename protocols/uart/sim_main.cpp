
// sim_main.cpp
#include "Vuart.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);

    // Create instance of DUT
    Vuart* tb = new Vuart;

    // Setup VCD waveform dump
    VerilatedVcdC* tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    tb->trace(tfp, 99);
    tfp->open("dump.vcd");

    // Simulation signals
    tb->clk = 0;
    tb->reset = 1;

    const int max_cycles = 100;  // number of clock cycles
    for (int i = 0; i < max_cycles; i++) {
        // Toggle clock
        tb->clk = 0;
        tb->eval();
        tfp->dump(2*i);

        tb->clk = 1;
        tb->eval();
        tfp->dump(2*i+1);

        // Release reset after 2 cycles
        if (i == 1) tb->reset = 0;
    }

    // Finish simulation
    tb->final();
    tfp->close();
    delete tb;
    delete tfp;
    return 0;
}
